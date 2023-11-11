import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localization/localization.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:smart_work/presentation/widgets/pomodoro/pomodoro_widget.dart';
import 'package:smart_work/presentation/widgets/pomodoro/stopwatch.dart';
import 'package:smart_work/presentation/widgets/pomodoro/timer.dart';
import 'package:smart_work/utils/constants/maps.dart';
import '../../utils/constants/labels.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});
  static const routeName = '/pomodoro';

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  Widget getPomodoroWidget() {
    switch (AppCubit.get(context).selectedPomodoroMode) {
      case 0:
        return const TimerWidget();
      case 1:
        return const PomodoroWidget();
      case 2:
        return const StopwatchWidget();
      default:
        return const TimerWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 0,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
              statusBarColor: primaryColor,
              statusBarIconBrightness:
                  Platform.isIOS ? Brightness.dark : Brightness.light,
              statusBarBrightness: Brightness.dark,
              systemNavigationBarColor: primaryColor,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
          ),
          body: SafeArea(
            child: Stack(
              children: [
                AnimatedSwitcher(
                  transitionBuilder: (child, animation) => SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, -0.5),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                  duration: const Duration(milliseconds: 300),
                  child: Transform.flip(
                    flipX: locale.languageCode == "ar",
                    key: ValueKey<int>(cubit.selectedPomodoroMode),
                    child: Image.asset(
                      selectedModeImage[cubit.selectedPomodoroMode]!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: width * 70,
                    left: width * 20,
                    right: width * 20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              cubit.changePomodoroMode(index: 0);
                            },
                            child: ModeTile(
                              //TODO: Replace with sand clock
                              icon: 'assets/icons/sand_clock.svg',
                              title: 'Timer'.i18n(),
                              isSelected: cubit.selectedPomodoroMode == 0,
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              cubit.changePomodoroMode(index: 1);
                            },
                            child: ModeTile(
                              icon: 'assets/icons/pomodoro.svg',
                              title: 'Pomodoro'.i18n(),
                              isSelected: cubit.selectedPomodoroMode == 1,
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              cubit.changePomodoroMode(index: 2);
                            },
                            child: ModeTile(
                              icon: 'assets/icons/stopwatch.svg',
                              title: 'Stop Watch'.i18n(),
                              isSelected: cubit.selectedPomodoroMode == 2,
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: getPomodoroWidget(),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(width * 10),
                          decoration: ShapeDecoration(
                            color: const Color(0x0CC1B2FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                width * 8,
                              ),
                            ),
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/arrow_down.svg",
                            height: width * 27,
                            width: width * 27,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: width * 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class ModeTile extends StatelessWidget {
  const ModeTile({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
  });

  final String icon, title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          icon,
          height: width * 40,
          colorFilter: ColorFilter.mode(
            isSelected ? const Color(0xFFC1B2FF) : Colors.white,
            BlendMode.srcIn,
          ),
        ),
        SizedBox(
          height: width * 10,
        ),
        Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFFC1B2FF) : Colors.white,
            fontSize: textSize * 12,
            fontFamily: 'SFPro',
            fontWeight: FontWeight.w400,
          ),
        ),
        if (isSelected) ...[
          SizedBox(
            height: width * 10,
          ),
          Container(
            width: width * 4,
            height: width * 4,
            decoration: const ShapeDecoration(
              color: Color(0xFFC1B2FF),
              shape: OvalBorder(),
              shadows: [
                BoxShadow(
                  color: Color(0x7FC1B2FF),
                  blurRadius: 10,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                )
              ],
            ),
          )
        ],
      ],
    );
  }
}
