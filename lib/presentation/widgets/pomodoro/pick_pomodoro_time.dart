import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import '../../../utils/constants/labels.dart';
import 'pomodoro_widget.dart';
import 'start_clock.dart';

class PickPomodoroTime extends StatefulWidget {
  const PickPomodoroTime({super.key, required this.stopWatch});
  final bool stopWatch;

  @override
  State<PickPomodoroTime> createState() => _PickPomodoroTimeState();
}

class _PickPomodoroTimeState extends State<PickPomodoroTime> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: width * 60,
              ),
              TimeSlider(
                  title: "Pomodoro",
                  onChanged: (value) {
                    cubit.changePomodoroTime(pomodoro: value);
                  },
                  value: cubit.pomodoroTime),
              SizedBox(
                height: height * 20,
              ),
              TimeSlider(
                  title: "Long Break",
                  onChanged: (value) {
                    cubit.changePomodoroTime(longBreak: value);
                  },
                  value: cubit.longBreakTime),
              SizedBox(
                height: height * 20,
              ),
              TimeSlider(
                title: "Short Break",
                onChanged: (value) {
                  cubit.changePomodoroTime(shortBreak: value);
                },
                value: cubit.shortBreakTime,
              ),
              SizedBox(
                height: width * 20,
              ),
              GestureDetector(
                onTap: () {
                  cubit.startPomodoroTimer();
                },
                child: const StartClock(
                  stopwatch: false,
                ),
              ),
              SizedBox(
                height: width * 40,
              ),
            ],
          ),
        );
      },
    );
  }
}
