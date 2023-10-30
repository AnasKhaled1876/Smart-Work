import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_work/injection.dart';

import '../../domain/models/task.dart';
import '../../domain/models/user_profile.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  UserProfile? userProfile;

  void changeIndex(int index) {
    currentIndex = index;
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
      userProfile = UserProfile.fromJson(value.data);
      emit(RegisterUserSuccessState());
    }).catchError((error) {
      emit(RegisterUserErrorState(error.toString()));
    });
  }

  void loginUser({required String email, required String password}) {
    emit(LoginLoadingState());
    locator<Dio>().post('/user/login', queryParameters: {
      'email': email,
      'password': password,
    }).then((value) {
      userProfile = UserProfile.fromJson(value.data);
      emit(LoginSuccessState());
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  void addTask({required String title, required String description}) {
    emit(AddTaskLoadingState());
    locator<Dio>().post('/task/addTask', data: {
      'title': title,
      'description': description,
    }).then((value) {
      userProfile = UserProfile.fromJson(value.data);
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

  void addNote({required String title, required String description}) {
    emit(AddNoteLoadingState());
    locator<Dio>().post('/note/add', data: {
      'title': title,
      'description': description,
    }).then((value) {
      emit(AddNoteSuccessState());
    }).catchError((error) {
      emit(AddNoteErrorState(error.toString()));
    });
  }

  void updateNote() {
    emit(UpdateNotesLoadingState());
    locator<Dio>().put('/note/updateNote').then((value) {
      //TODO: Add notes to user profile
      emit(UpdateNotesSuccessState());
    }).catchError((error) {
      emit(UpdateNotesErrorState(error.toString()));
    });
  }
}
