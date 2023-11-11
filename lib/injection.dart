import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  final Dio dio = Dio();
  dio.options
    ..baseUrl = 'http://spekyl2023-001-site3.atempurl.com/'
    ..connectTimeout = const Duration(seconds: 10)
    ..receiveTimeout = const Duration(seconds: 10)
    // ..headers = {
    //   'Content-Type': 'application/json',
    // }
    ..followRedirects = false;

  dio.interceptors.add(AwesomeDioInterceptor());

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  locator.registerSingleton<FlutterSecureStorage>(storage);

  locator.registerSingleton<Dio>(dio);

  String? pomodoro =
      await locator<FlutterSecureStorage>().read(key: "pomodoroTime");
  String? longBreak =
      await locator<FlutterSecureStorage>().read(key: "longBreak");
  String? shortBreak =
      await locator<FlutterSecureStorage>().read(key: "shortBreak");
  if (pomodoro == null || longBreak == null || shortBreak == null) {
    locator<FlutterSecureStorage>().write(key: "pomodoroTime", value: "45");
    locator<FlutterSecureStorage>().write(key: "longBreak", value: "15");
    locator<FlutterSecureStorage>().write(key: "shortBreak", value: "5");
  }
  // locator.registerSingleton<ApiRepository>(
  //   ApiRepositoryImpl(
  //     locator<ProfileApiService>(),
  //     locator<AuthApiService>(),
  //     locator<PlacesApiService>(),
  //     locator<ReviewApiService>(),
  //     locator<BookingApiService>(),
  //   ),
  // );
}
