import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:smart_work/utils/constants/labels.dart';

class StartClock extends StatelessWidget {
  const StartClock({
    super.key,
    required this.stopwatch,
  });
  final bool stopwatch;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            if (stopwatch) {
              cubit.startStopWatch();
            } else {
              cubit.startPomodoroTimer();
            }
          },
          child: Stack(
            children: [
              Image.asset(
                "assets/images/clock_ticks.png",
                height: height * 210,
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/inner_shadow_ellipse.png",
                    width: width * 160,
                    height: width * 160,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: width * 121,
                    height: width * 121,
                    decoration: const ShapeDecoration(
                      color: primaryColor,
                      shape: OvalBorder(),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: width * 120,
                    height: width * 120,
                    decoration: const ShapeDecoration(
                      color: secondaryColor,
                      shape: OvalBorder(),
                      shadows: [
                        BoxShadow(
                          color: Color(0x70C1B2FF),
                          blurRadius: 40,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                  child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/play.svg",
                      height: width * 20,
                      width: width * 20,
                    ),
                    SizedBox(
                      height: height * 6,
                    ),
                    Text(
                      'START',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: textSize * 14.13,
                        fontFamily: 'SFPro',
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        );
      },
    );
  }
}
