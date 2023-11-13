import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localization/localization.dart';
import 'package:smart_work/config/themes/main_theme.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import 'package:smart_work/injection.dart';
import 'package:smart_work/presentation/screens/about/help.dart';
import 'package:smart_work/presentation/screens/about/notifications.dart';
import 'package:smart_work/presentation/screens/about/rate_us.dart';
import 'package:smart_work/presentation/screens/about/settings.dart';
import 'package:smart_work/presentation/screens/home.dart';
import 'package:smart_work/presentation/screens/on_boarding.dart';
import 'package:smart_work/presentation/screens/pomodoro.dart';
import 'package:smart_work/presentation/screens/settings/personal_settings.dart';
import 'package:smart_work/presentation/screens/sign_up.dart';
import 'package:smart_work/presentation/screens/splash.dart';
import 'package:smart_work/presentation/widgets/note/note_details.dart';
import 'package:smart_work/presentation/widgets/task/add_task.dart';
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
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
  locale = await locator<FlutterSecureStorage>().read(key: 'language') == 'ar'
      ? const Locale('ar', 'SA')
      : const Locale('en', 'US');
  String? previousState =
      await locator<FlutterSecureStorage>().read(key: 'previousState');

  if (previousState == 'true') {
    await locator<FlutterSecureStorage>()
        .write(key: 'nextState', value: '');
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.changeLanguage(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  changeLanguage(Locale passedLocale) {
    setState(() {
      locale = passedLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];
    double baseWidth = 393;
    double fem = MediaQuery.sizeOf(context).width / baseWidth;
    double ffem = fem * 0.97;
    textSize = ffem;
    height = fem;
    width = fem;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: MaterialApp(
        locale: locale,
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        localizationsDelegates: [
          // delegate from flutter_localization
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          // delegate from localization package.
          LocalJsonLocalization.delegate,
        ],
        debugShowCheckedModeBanner: false,
        theme: mainTheme,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'SA'),
        ],
        routes: {
          '/splash': (context) => const SplashScreen(),
          OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
          AddInfoScreen.routeName: (context) => const AddInfoScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          PomodoroScreen.routeName: (context) => const PomodoroScreen(),
          NoteDetailsScreen.routeName: (context) => const NoteDetailsScreen(),
          TaskDetailsScreen.routeName: (context) => const TaskDetailsScreen(),
          AddTaskScreen.routeName: (context) => const AddTaskScreen(),
          NotificationsScreen.routeName: (context) =>
              const NotificationsScreen(),
          SettingsScreen.routeName: (context) => const SettingsScreen(),
          PersonalSettingsScreen.routeName: (context) =>
              const PersonalSettingsScreen(),
          RateUsScreen.routeName: (context) => const RateUsScreen(),
          HelpScreen.routeName: (context) => const HelpScreen(),
        },
        initialRoute: '/splash',
      ),
    );
  }
}
