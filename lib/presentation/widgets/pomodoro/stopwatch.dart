import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import 'package:smart_work/presentation/widgets/pomodoro/pomodoro_clock.dart';
import 'package:smart_work/presentation/widgets/pomodoro/start_clock.dart';
import '../../../utils/constants/labels.dart';
import '../../assets/color_manager.dart';

class StopwatchWidget extends StatefulWidget {
  const StopwatchWidget({super.key});

  @override
  State<StopwatchWidget> createState() => _StopwatchWidgetState();
}

class _StopwatchWidgetState extends State<StopwatchWidget>
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

  bool isRunning = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: cubit.stopwatchTime != Duration.zero ||
                      cubit.stopwatchTimer != null
                  ? const PomodoroClock(
                      stopWatch: true,
                    )
                  : const StartClock(
                      stopwatch: true,
                    ),
            ),
            SizedBox(
              height: width * 30,
            ),
            if (cubit.stopwatchTime != Duration.zero ||
                cubit.stopwatchTimer != null)
              InkWell(
                onTap: () {
                  if (cubit.stopwatchTimer != null) {
                    cubit.resetStopWatch();
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
        );
      },
    );
  }
}
