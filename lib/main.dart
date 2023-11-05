import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import 'package:smart_work/injection.dart';
import 'package:smart_work/presentation/screens/sign_up.dart';
import 'package:smart_work/presentation/screens/home.dart';
import 'package:smart_work/presentation/screens/on_boarding.dart';
import 'package:smart_work/presentation/screens/splash.dart';
import 'package:smart_work/config/themes/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_work/presentation/widgets/note/note_details.dart';
import 'package:smart_work/presentation/widgets/task/new_task.dart';
import 'package:smart_work/presentation/widgets/task/task_details.dart';
import 'firebase_options.dart';
import 'utils/constants/labels.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 393;
    double fem = MediaQuery.sizeOf(context).width / baseWidth;
    double ffem = fem * 0.97;
    textSize = ffem;
    height = fem;
    width = fem;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: mainTheme,
        routes: {
          '/splash': (context) => const SplashScreen(),
          OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
          AddInfoScreen.routeName: (context) => const AddInfoScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          NoteDetailsScreen.routeName: (context) => const NoteDetailsScreen(),
          TaskDetailsScreen.routeName: (context) => const TaskDetailsScreen(),
          AddTaskScreen.routeName: (context) => const AddTaskScreen(),
        },
        initialRoute: '/splash',
      ),
    );
  }
}
