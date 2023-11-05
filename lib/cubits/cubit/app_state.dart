part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class AppChangeBottomNavBarState extends AppState {}

final class AppChangingState extends AppState {}

final class RegisterUserLoadingState extends AppState {}

final class RegisterUserSuccessState extends AppState {}

final class RegisterUserErrorState extends AppState {
  final String error;

  RegisterUserErrorState(this.error);
}

final class LoginLoadingState extends AppState {}

final class LoginSuccessState extends AppState {}

final class LoginErrorState extends AppState {
  final String error;

  LoginErrorState(this.error);
}

final class AddTaskLoadingState extends AppState {}

final class AddTaskSuccessState extends AppState {}

final class AddTaskErrorState extends AppState {
  final String error;

  AddTaskErrorState(this.error);
}

final class UpdateTasksLoadingState extends AppState {}

final class UpdateTasksSuccessState extends AppState {}

final class UpdateTasksErrorState extends AppState {
  final String error;

  UpdateTasksErrorState(this.error);
}

final class UpdateNotesLoadingState extends AppState {}

final class UpdateNotesSuccessState extends AppState {}

final class UpdateNotesErrorState extends AppState {
  final String error;

  UpdateNotesErrorState(this.error);
}


final class DeleteTaskLoadingState extends AppState {}

final class DeleteTaskSuccessState extends AppState {}

final class DeleteTaskErrorState extends AppState {
  final String error;

  DeleteTaskErrorState(this.error);
}

final class AddNoteLoadingState extends AppState {}

final class AddNoteSuccessState extends AppState {}

final class AddNoteErrorState extends AppState {
  final String error;

  AddNoteErrorState(this.error);
}

final class DeleteNoteLoadingState extends AppState {}

final class DeleteNoteSuccessState extends AppState {}

final class DeleteNoteErrorState extends AppState {
  final String error;

  DeleteNoteErrorState(this.error);
}
