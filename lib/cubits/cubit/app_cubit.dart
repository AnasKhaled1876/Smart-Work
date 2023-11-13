import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:smart_work/domain/models/notification.dart';
import 'package:smart_work/injection.dart';

import '../../domain/models/note.dart';
import '../../domain/models/task.dart';
import '../../domain/models/user_profile.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0, counter = 0;
  CalendarController? calendarController;
  Timer? pomodoroTimer, stopwatchTimer, mainTimer;
  String? pomodoroTitle;
  Duration pomodoroDuration = const Duration(minutes: 0);
  Duration longBreakDuration = const Duration(minutes: 0);
  Duration shortBreakDuration = const Duration(minutes: 0);
  List<SmartNotification>? notifications;
  List<List<SmartNotification>>? groupedByDateNotifications;
  DateTime? selectedDate;
  double pomodoroTime = 45, shortBreakTime = 5, longBreakTime = 15;
  TimeOfDay? pickedTaskTime;
  DateTime? pickedTaskDate;
  Duration stopwatchTime = Duration.zero;
  int selectedPomodoroMode = 0;
  Note? selectedNote;
  Task? selectedTask;
  DateTime now = DateTime.now();
  int selectedNoteCategory = 0, selectedTaskCategory = 0;
  TabController? noteTabController, calendarTabController, tasksTabController;
  UserProfile? userProfile;
  AdvancedDrawerController advancedDrawerController =
      AdvancedDrawerController();

  void changeSelectedDate({required DateTime date}) {
    emit(AppChangingState());
    calendarController!.selectedDate = date;
    calendarController!.displayDate = date;
    emit(AppChangeBottomNavBarState());
  }

  void getNotifications() {
    emit(AppChangingState());

    // Get all notifications
    final allNotifications = notifications ?? [];

    // Get today's date at midnight
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Get yesterday's date at midnight
    final yesterday = today.subtract(Duration(days: 1));

    // Group notifications by date
    final groupedNotifications = <DateTime, List<SmartNotification>>{};
    for (final notification in allNotifications) {
      final date = DateTime(notification.timestamp.year,
          notification.timestamp.month, notification.timestamp.day);
      if (!groupedNotifications.containsKey(date)) {
        groupedNotifications[date] = [];
      }
      groupedNotifications[date]!.add(notification);
    }

    // Sort notifications by date
    final sortedNotifications = groupedNotifications.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));

    // Add today's and yesterday's notifications to the top of the list
    final todayNotifications =
        sortedNotifications.firstWhere((entry) => entry.key == today).value;
    final yesterdayNotifications =
        sortedNotifications.firstWhere((entry) => entry.key == yesterday).value;
    final otherNotifications = sortedNotifications
        .where((entry) => entry.key != today && entry.key != yesterday)
        .toList();
    final groupedByDateNotifications = [
      if (todayNotifications.isNotEmpty)
        [
          SmartNotification(
              title: 'Today', message: '', type: '', timestamp: DateTime.now()),
          ...todayNotifications
        ],
      if (yesterdayNotifications.isNotEmpty)
        [
          SmartNotification(
              title: 'Yesterday',
              message: '',
              type: '',
              timestamp: DateTime.now().subtract(const Duration(days: 1))),
          ...yesterdayNotifications
        ],
      ...otherNotifications.map((entry) => [
            SmartNotification(
                title: '${entry.key.day}/${entry.key.month}/${entry.key.year}',
                message: '',
                type: '',
                timestamp: entry.key),
            ...entry.value
          ]),
    ];

    // Set notifications
    this.groupedByDateNotifications = groupedByDateNotifications;

    emit(AppNotificationsLoaded());
  }

  void changePomodoroTime(
      {double? pomodoro, double? shortBreak, double? longBreak}) {
    emit(AppChangingState());
    pomodoroTime = pomodoro ?? pomodoroTime;
    shortBreakTime = shortBreak ?? shortBreakTime;
    longBreakTime = longBreak ?? longBreakTime;
    pomodoroDuration = Duration(minutes: pomodoroTime.toInt());
    shortBreakDuration = Duration(minutes: shortBreakTime.toInt());
    longBreakDuration = Duration(minutes: longBreakTime.toInt());
    emit(AppChangeBottomNavBarState());
  }

  void changeTimeMode({required int index}) {
    emit(AppChangingState());
    selectedPomodoroMode = index;
    emit(AppChangeBottomNavBarState());
  }

  void startPomodoroTimer() async {
    emit(AppChangingState());

    if (pomodoroDuration == Duration.zero) {
      final nextState =
          await locator<FlutterSecureStorage>().read(key: "next state");
      switch (nextState) {
        case 'pomodoro':
          pomodoroDuration = Duration(minutes: pomodoroTime.toInt());
          pomodoroTitle = 'Pomodoro';
          break;
        case 'shortBreak':
          pomodoroDuration = Duration(minutes: shortBreakTime.toInt());
          pomodoroTitle = 'Short Break';
          break;
        case 'longBreak':
          pomodoroDuration = Duration(minutes: longBreakTime.toInt());
          pomodoroTitle = 'Long Break';
          break;
        default:
          throw Exception('Invalid previous state: $nextState');
      }
      await locator<FlutterSecureStorage>().write(
          key: "pomodoroStartTime", value: DateTime.now().toIso8601String());
    }
    pomodoroTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      emit(AppChangeBottomNavBarState());
      emit(AppChangingState());
      if (pomodoroDuration.inMinutes >= pomodoroTime.toInt()) {
        pomodoroTimer!.cancel();
        pomodoroTimer = null;
        pomodoroDuration = Duration.zero;
        final next =
            await locator<FlutterSecureStorage>().read(key: "next state");
        if (next == 'pomodoro' && counter == 2) {
          await locator<FlutterSecureStorage>()
              .write(key: "next state", value: "longBreak");
          counter = 0;
        } else if (next == 'pomodoro') {
          await locator<FlutterSecureStorage>()
              .write(key: "next state", value: "shortBreak");
        } else if (next == "shortBreak") {
          await locator<FlutterSecureStorage>()
              .write(key: "next state", value: "pomodoro");
          counter++;
        }

        emit(AppChangeBottomNavBarState());
        return;
      } else {
        pomodoroDuration = pomodoroDuration + const Duration(seconds: 1);
      }
      emit(AppChangeBottomNavBarState());
    });
    emit(AppChangeBottomNavBarState());
  }

  void stopPomodoroTimer() {
    emit(AppChangingState());
    pomodoroTimer!.cancel();
    pomodoroTimer = null;
    emit(AppChangeBottomNavBarState());
  }

  void stopStopWatch() {
    emit(AppChangingState());
    stopwatchTimer!.cancel();
    stopwatchTimer = null;
    emit(AppChangeBottomNavBarState());
  }

  // Future<void> startNextTimer() async {
  //   emit(AppChangingState());

  //   final storage = locator<FlutterSecureStorage>();
  //   final previousState = await storage.read(key: 'previousState');

  //   late Duration duration;

  // switch (previousState) {
  //   case 'pomodoro':
  //     duration = pomodoroDuration;
  //     pomodoroTitle = 'Pomodoro';
  //     break;
  //   case 'shortBreak':
  //     duration = shortBreakDuration;
  //     pomodoroTitle = 'Short Break';
  //     break;
  //   case 'longBreak':
  //     duration = longBreakDuration;
  //     pomodoroTitle = 'Long Break';
  //     break;
  //   default:
  //     throw Exception('Invalid previous state: $previousState');
  // }

  //   mainTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
  //     emit(AppChangeBottomNavBarState());
  //     emit(AppChangingState());
  //     if (duration.inMinutes == 0) {
  //       mainTimer!.cancel();
  //       mainTimer = null;
  //       await locator<FlutterSecureStorage>().write(
  //           key: "pomodoroStartTime", value: DateTime.now().toIso8601String());
  //       if (counter == 2) {
  //         await locator<FlutterSecureStorage>()
  //             .write(key: "Previous State", value: "longBreak");
  //       } else {
  //         if(previousState == 'pomodoro'){
  //           counter++;
  //         }

  //       }

  //       emit(AppChangeBottomNavBarState());
  //       return;
  //     } else {
  //       duration -= const Duration(seconds: 1);
  //     }
  //     emit(AppChangeBottomNavBarState());
  //   });

  //   emit(AppChangeBottomNavBarState());
  // }

  // void stopMainTimer() {
  //   emit(AppChangingState());
  //   mainTimer!.cancel();
  //   mainTimer = null;
  //   emit(AppChangeBottomNavBarState());
  // }

  Future startStopWatch() async {
    emit(AppChangingState());
    if (stopwatchTime == Duration.zero) {
      await locator<FlutterSecureStorage>().write(
        key: "stopwatchStartTime",
        value: DateTime.now().toIso8601String(),
      );
    }
    stopwatchTimer = Timer.periodic(const Duration(milliseconds: 5), (timer) {
      emit(AppChangeBottomNavBarState());
      emit(AppChangingState());
      stopwatchTime = stopwatchTime + const Duration(milliseconds: 5);
      emit(AppChangeBottomNavBarState());
    });
  }

  void resetStopWatch() async {
    emit(AppChangingState());
    stopwatchTimer!.cancel();
    await locator<FlutterSecureStorage>().delete(key: "stopwatchStartTime");
    stopwatchTimer = null;
    stopwatchTime = Duration.zero;
    emit(AppChangeBottomNavBarState());
  }

  void resetPomodoroTimer() async {
    emit(AppChangingState());
    pomodoroTimer!.cancel();
    await locator<FlutterSecureStorage>().delete(key: "pomodoroStartTime");
    pomodoroTimer = null;
    pomodoroDuration = Duration.zero;
    emit(AppChangeBottomNavBarState());
  }

  void changeIndex(int index) {
    emit(AppChangingState());
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void pickPomodoroMode(int index) {
    emit(AppChangingState());
    selectedPomodoroMode = index;
    emit(AppChangeBottomNavBarState());
  }

  void refreshTime() {
    emit(AppChangingState());
    now = DateTime.now();
    emit(AppChangeBottomNavBarState());
  }

  void changeTaskDate({required DateTime date}) {
    emit(AppChangingState());
    pickedTaskDate = date;
    emit(AppChangeBottomNavBarState());
  }

  void changeTaskTime({required TimeOfDay time}) {
    emit(AppChangingState());
    pickedTaskTime = time;
    emit(AppChangeBottomNavBarState());
  }

  void pickNoteCategory(int index) {
    emit(AppChangingState());
    selectedNoteCategory = index;
    emit(AppChangeBottomNavBarState());
  }

  void pickTaskCategory(int index) {
    emit(AppChangingState());
    selectedTaskCategory = index;
    emit(AppChangeBottomNavBarState());
  }

  void registerUser({required UserProfile user}) {
    emit(RegisterUserLoadingState());
    locator<Dio>()
        .post(
      '/user/register',
      data: user.toJson(),
    )
        .then((value) {
      locator<FlutterSecureStorage>().write(key: "email", value: user.email);
      locator<FlutterSecureStorage>()
          .write(key: "password", value: user.password);
      userProfile = UserProfile.fromMap(value.data["user"]);
      emit(RegisterUserSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(RegisterUserErrorState(error.toString()));
    });
  }

  void loginUser({required String email, required String password}) {
    emit(LoginLoadingState());
    locator<Dio>().get('/user/login', queryParameters: {
      'email': email,
      'password': password,
    }).then((value) {
      userProfile = UserProfile.fromMap(value.data["user"]);
      emit(LoginSuccessState());
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  void addTask({required Task task}) {
    emit(AddTaskLoadingState());
    locator<Dio>().post(
      '/task/addTask',
      data: {
        ...task.toMap(),
        "userId": userProfile!.id!,
      },
    ).then((value) {
      if (userProfile!.tasks == null) {
        userProfile!.tasks = [];
      }
      userProfile!.tasks!.add(Task.fromMap(value.data));
      emit(AddTaskSuccessState());
    }).catchError((error) {
      emit(AddTaskErrorState(error.toString()));
    });
  }

  void updateTask({required Task task}) {
    emit(UpdateTasksLoadingState());
    locator<Dio>().put('/task/updateTask', data: task.toJson()).then(
      (value) {
        emit(UpdateTasksSuccessState());
      },
    ).catchError(
      (error) {
        emit(UpdateTasksErrorState(error.toString()));
      },
    );
  }

  void deleteTask({required int taskId}) {
    emit(DeleteTaskLoadingState());
    locator<Dio>().delete('/task/deleteTask', queryParameters: {
      'id': taskId,
    }).then((value) {
      userProfile!.tasks!.removeWhere((element) => element.id == taskId);
      emit(DeleteTaskSuccessState());
    }).catchError((error) {
      emit(DeleteTaskErrorState(error.toString()));
    });
  }

  void addNote({required Note note}) {
    emit(AddNoteLoadingState());
    locator<Dio>().post('/note/addNote', data: {
      ...note.toMap(),
      "userId": userProfile!.id!,
    }).then((value) {
      log(value.toString());
      if (userProfile!.notes == null) {
        userProfile!.notes = [];
      }
      userProfile!.notes!.add(Note.fromMap(value.data));
      emit(AddNoteSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(AddNoteErrorState(error.toString()));
    });
  }

  void updateNote({required Note note}) {
    emit(UpdateNotesLoadingState());
    locator<Dio>().put('/note/editNote', data: note.toJson(), queryParameters: {
      'id': note.id,
    }).then((value) {
      final updatedNote = Note.fromMap(value.data);
      final index = userProfile!.notes!
          .indexWhere((element) => element.id == selectedNote!.id);
      userProfile!.notes!.replaceRange(index, index + 1, [updatedNote]);

      emit(UpdateNotesSuccessState());
    }).catchError((error) {
      emit(UpdateNotesErrorState(error.toString()));
    });
  }

  void deleteNote({required int noteId}) {
    emit(DeleteNoteLoadingState());
    locator<Dio>().put('/note/deleteNote', queryParameters: {
      'id': noteId,
    }).then((value) {
      userProfile!.notes!.removeWhere((element) => element.id == noteId);
      emit(DeleteNoteSuccessState());
    }).catchError((error) {
      emit(DeleteNoteErrorState(error.toString()));
    });
  }
}
