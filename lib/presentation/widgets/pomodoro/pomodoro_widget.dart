import 'package:localization/localization.dart';
import 'package:smart_work/presentation/widgets/pomodoro/pick_pomodoro_time.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:smart_work/utils/constants/labels.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'pomodoro_clock.dart';

class PomodoroWidget extends StatefulWidget {
  const PomodoroWidget({super.key});

  @override
  State<PomodoroWidget> createState() => _PomodoroWidgetState();
}

class _PomodoroWidgetState extends State<PomodoroWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: AppCubit.get(context).pomodoroDuration != Duration.zero
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const PomodoroClock(
                      stopWatch: false,
                    ),
                    SizedBox(
                      height: width * 30,
                    ),
                    InkWell(
                      onTap: () {
                        if (cubit.pomodoroTimer != null) {
                          cubit.resetPomodoroTimer();
                        }
                      },
                      child: Text(
                        'RESET',
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: textSize * 22.93,
                          fontFamily: 'SFPro',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                )
              : const PickPomodoroTime(
                  stopWatch: false,
                ),
        );
      },
    );
  }
}

class TimeSlider extends StatelessWidget {
  const TimeSlider(
      {super.key,
      required this.onChanged,
      required this.value,
      required this.title,
      required this.min,
      required this.max});
  final Function onChanged;
  final double value, min, max;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 20,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: textSize * 16,
                    fontFamily: 'SFPro',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.20,
                  ),
                ),
              ),
              Text(
                'Min'.i18n(),
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: const Color(0xFFC1B2FF),
                  fontSize: textSize * 13,
                  fontFamily: 'SFPro',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.20,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: width * 2,
        ),
        Row(
          children: [
            Expanded(
              child: SfSliderTheme(
                data: SfSliderThemeData(
                  thumbRadius: width * 8,
                  activeTrackHeight: width * 3,
                  inactiveTrackHeight: width * 3,
                  activeTrackColor: secondaryColor,
                  inactiveTrackColor: Colors.white,
                  activeLabelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: textSize * 14,
                    fontFamily: 'SFPro',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.20,
                  ),
                  inactiveLabelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: textSize * 14,
                    fontFamily: 'SFPro',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.20,
                  ),
                  thumbColor: secondaryColor,
                  tooltipBackgroundColor: secondaryColor,
                  tooltipTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: textSize * 10,
                    fontFamily: 'SFPro',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.20,
                  ),
                ),
                child: SfSlider(
                  min: min,
                  max: max,
                  value: value,
                  activeColor: secondaryColor,
                  inactiveColor: Colors.white,
                  showDividers: false,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 1,
                  onChanged: (dynamic value) => onChanged(value),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
