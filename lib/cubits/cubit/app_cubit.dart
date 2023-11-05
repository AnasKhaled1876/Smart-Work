import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:smart_work/injection.dart';

import '../../domain/models/note.dart';
import '../../domain/models/task.dart';
import '../../domain/models/user_profile.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  CalendarController? calendarController;
  DateTime? selectedDate;
  TimeOfDay? pickedTaskTime;
  DateTime? pickedTaskDate;
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
