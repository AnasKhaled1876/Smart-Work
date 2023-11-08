import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:smart_work/presentation/screens/about/notifications.dart';
import 'package:smart_work/presentation/widgets/main/note.dart';
import 'package:smart_work/presentation/widgets/main/task.dart';
import 'package:smart_work/presentation/widgets/task/new_task.dart';
import 'package:smart_work/utils/constants/labels.dart';
import 'package:smart_work/utils/constants/maps.dart';
import 'package:smart_work/utils/extensions/duration.dart';
import 'package:smart_work/utils/extensions/string.dart';
import '../../injection.dart';
import '../../utils/constants/images.dart';
import '../widgets/drawer.dart';
import '../widgets/home/icon_container.dart';
import '../widgets/main/calendar.dart';
import '../widgets/main/home.dart';
import '../widgets/note/add_note.dart';
import 'pomodoro.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    locator<FlutterSecureStorage>()
        .read(
      key: "stopwatch",
    )
        .then((value) {
      if (value != null) {
        AppCubit.get(context).stopwatchTime =
            const Duration().parseDuration(value);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.inactive:
        print('App is inactive');
        break;
      case AppLifecycleState.paused:
        print('App is paused');
        locator<FlutterSecureStorage>().write(
          key: "stopwatch",
          value: AppCubit.get(context).stopwatchTime.toString(),
        );
        break;
      case AppLifecycleState.resumed:
        print('App is resumed');
        break;
      case AppLifecycleState.detached:
        print('App is detached');
        break;
      case AppLifecycleState.hidden:
        print('App is hidden');
        break;
    }
  }

  Widget getDisplayedWidget() {
    switch (AppCubit.get(context).currentIndex) {
      case 0:
        return const HomeWidget();
      case 1:
        return const CalendarWidget();
      case 3:
        return const NoteWidget();
      case 4:
        return const TaskWidget();

      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return AdvancedDrawer(
          controller: cubit.advancedDrawerController,
          backdropColor: primaryColor,
          openRatio: 0.4,
          openScale: 0.7,
          childDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(width * 16),
          ),
          drawer: const AdvancedDrawerWidget(),
          child: Scaffold(
            extendBody: true,
            appBar: AppBar(
              toolbarHeight: 0,
              elevation: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark,
                systemNavigationBarColor: Colors.white,
                systemNavigationBarIconBrightness: Brightness.light,
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width * 16),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: width * 28,
                  vertical: height * 40,
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconContainer(
                          onTap: () {
                            cubit.advancedDrawerController.showDrawer();
                          },
                          child: SvgPicture.asset(
                            'assets/icons/menu.svg',
                            colorFilter: const ColorFilter.mode(
                              Color(0xFF242041),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 16,
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 600),
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0.0, -0.5),
                                  end: const Offset(0, 0),
                                ).animate(animation),
                                child: child,
                              ),
                            );
                          },
                          child: cubit.currentIndex == 0
                              ? WelcomeRow(
                                  name: cubit.userProfile!.name!.toTitleCase())
                              : Text(
                                  titleMap[cubit.currentIndex]!,
                                  textAlign: TextAlign.start,
                                  key: ValueKey<String>(
                                      titleMap[cubit.currentIndex]!),
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: textSize * 22,
                                    fontFamily: 'SFPro',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.50,
                                  ),
                                ),
                        ),
                        const Spacer(),
                        IconContainer(
                          onTap: () {
                            switch (cubit.currentIndex) {
                              case 0:
                                Navigator.pushNamed(
                                    context, NotificationsScreen.routeName);
                                break;
                              case 1:
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2021),
                                  lastDate: DateTime(2025),
                                ).then((value) {
                                  if (value != null) {
                                    cubit.selectedDate = value;
                                    cubit.changeSelectedDate(date: value);
                                  }
                                });
                                break;
                              case 3:
                                showDialog(
                                  useSafeArea: true,
                                  context: context,
                                  builder: (context) => const AlertDialog(
                                    backgroundColor: Colors.white,
                                    contentPadding: EdgeInsets.zero,
                                    content: AddNoteSheet(),
                                  ),
                                );
                                break;
                              case 4:
                                Navigator.pushNamed(
                                    context, AddTaskScreen.routeName);
                                break;
                              default:
                                cubit.advancedDrawerController.showDrawer();
                            }
                          },
                          child: sideButton[cubit.currentIndex]!,
                        )
                      ],
                    ),
                    SizedBox(height: height * 40),
                    AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: getDisplayedWidget()),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              height: height * 90,
              padding: EdgeInsets.only(
                left: width * 28,
                right: width * 28,
                top: height * 20,
                bottom: height * 10,
              ),
              shape: const CircularNotchedRectangle(),
              color: Colors.white,
              shadowColor: Colors.white,
              surfaceTintColor: Colors.white,
              elevation: 30,
              notchMargin: width * 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  5,
                  (index) => index == 2
                      ? SizedBox(
                          width: width * 20,
                        )
                      : InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            cubit.changeIndex(index);
                          },
                          child: BottomBarIcon(
                            iconPath:
                                bottomBarIcons[index > 2 ? index - 1 : index],
                            label:
                                bottomBarLabels[index > 2 ? index - 1 : index],
                            picked: cubit.currentIndex == index,
                          ),
                        ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, PomodoroScreen.routeName);
              },
              backgroundColor: primaryColor,
              child: SvgPicture.asset(
                'assets/icons/stopwatch.svg',
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
                width: width * 24,
                height: height * 24,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
          ),
        );
      },
    );
  }
}

class BottomBarIcon extends StatelessWidget {
  const BottomBarIcon({
    super.key,
    required this.iconPath,
    required this.label,
    required this.picked,
  });
  final String iconPath, label;
  final bool picked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          iconPath,
          colorFilter: ColorFilter.mode(
            picked ? primaryColor : Color(0xffACAEBE),
            BlendMode.srcIn,
          ),
          width: width * 24,
          height: height * 24,
        ),
        SizedBox(
          height: height * 4,
        ),
        Text(
          label,
          style: TextStyle(
            color: picked ? primaryColor : Color(0xffACAEBE),
            fontSize: textSize * 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
