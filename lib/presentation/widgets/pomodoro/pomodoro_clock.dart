import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';

import '../../../utils/constants/labels.dart';
import '../../assets/color_manager.dart';

class PomodoroClock extends StatelessWidget {
  const PomodoroClock({
    super.key,
    required this.stopWatch,
  });
  final bool stopWatch;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Stack(
          children: [
            Image.asset(
              "assets/images/inner_shadow_ellipse.png",
              width: width * 280,
              height: width * 280,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/clock_ticks.png",
                  height: height * 240,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
                child: Align(
              alignment: Alignment.center,
              child: Container(
                width: width * 169,
                height: width * 169,
                decoration: const ShapeDecoration(
                  color: primaryColor,
                  shape: OvalBorder(),
                  shadows: [
                    BoxShadow(
                      color: Color(0x2DC1B2FF),
                      blurRadius: 20,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
            )),
            Positioned.fill(
                child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    stopWatch
                        ? "${cubit.stopwatchTime.inMinutes.toString().padLeft(2, '0')}:${(cubit.stopwatchTime.inSeconds % 60).toString().padLeft(2, '0')}:${(cubit.stopwatchTime.inMilliseconds % 1000 ~/ 10).toString().padLeft(2, '0')}"
                        : '00\t:\t00\t:\t00',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: textSize * 26.40,
                      fontFamily: 'SFPro',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (!stopWatch) ...[
                    SizedBox(
                      height: height * 6,
                    ),
                    Text(
                      'Short Break',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: textSize * 13,
                        fontFamily: 'SFPro',
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ],
              ),
            )),
            cubit.stopwatchTimer != null && cubit.stopwatchTimer!.isActive
                ? Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: width * 165,
                        height: width * 165,
                        child: CircularProgressIndicator(
                          strokeWidth: width * 2,
                          color: secondaryColor,
                          value: stopWatch ? null : cubit.pomodoroTime / 60,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
            Positioned.fill(
              child: Align(
                alignment: const Alignment(0, 1.1),
                child: GestureDetector(
                  onTap: () {
                    if (cubit.stopwatchTimer != null &&
                        cubit.stopwatchTimer!.isActive) {
                      cubit.stopwatchTimer?.cancel();
                    } else {
                      cubit.startStopWatch();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(width * 10),
                    decoration: const ShapeDecoration(
                      color: Color(0xFFC1B2FF),
                      shape: OvalBorder(),
                      shadows: [
                        BoxShadow(
                          color: Color(0x26000000),
                          blurRadius: 7,
                          offset: Offset(0, 0.70),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Icon(
                      cubit.stopwatchTimer != null &&
                              cubit.stopwatchTimer!.isActive
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: primaryColor,
                      size: width * 24,
                    ),
                  ),
                ),
              ),
            ),
            
          ],
        );
      },
    );
  }
}
