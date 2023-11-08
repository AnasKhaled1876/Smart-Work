import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:smart_work/utils/constants/labels.dart';

class MainBanner extends StatefulWidget {
  const MainBanner({
    super.key,
  });

  @override
  State<MainBanner> createState() => _MainBannerState();
}

class _MainBannerState extends State<MainBanner> {
  Timer? time;
  @override
  void initState() {
    super.initState();
    time = Timer.periodic(const Duration(seconds: 45), (timer) {
      AppCubit.get(context).refreshTime();
    });
  }

  @override
  void dispose() {
    time!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: width * 16, vertical: height * 24),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(width * 8),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat("h:mm a").format(cubit.now),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: textSize * 25.02,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: height * 6),
                  Text(
                    DateFormat("EEEE, dd MMMM yyyy").format(cubit.now),
                    style: TextStyle(
                      color: const Color(0xFFC1B2FF),
                      fontSize: textSize * 12.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: height * 31,
                  ),
                  Text(
                    '${cubit.userProfile!.tasks?.length ?? 0} Tasks',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: textSize * 12.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              //create a white wall clock with arrows that move according to the time

              SizedBox(
                height: height * 88,
                child: AnalogClock(
                  dateTime: DateTime.now(),
                  isKeepTime: true,
                  dialColor: Colors.white,
                  dialBorderColor: Colors.black,
                  dialBorderWidthFactor: 0.04,
                  markingColor: Colors.black,
                  markingRadiusFactor: 0,
                  markingWidthFactor: 1.0,
                  hourNumberColor: Colors.black,
                  hourNumbers: const [
                    '',
                    '',
                    '',
                    '',
                    '',
                    '',
                    '',
                    '',
                    '',
                    '',
                    '',
                    ''
                  ],
                  hourNumberSizeFactor: 1.0,
                  hourNumberRadiusFactor: 1.0,
                  hourHandColor: Colors.black,
                  hourHandWidthFactor: 1.0,
                  hourHandLengthFactor: 1.0,
                  minuteHandColor: Colors.black,
                  minuteHandWidthFactor: 1.4,
                  minuteHandLengthFactor: 1.0,
                  secondHandColor: Colors.black,
                  secondHandWidthFactor: 0,
                  secondHandLengthFactor: 1.0,
                  centerPointColor: Colors.black,
                  centerPointWidthFactor: 1.0,
                ),
              )

              // Stack(
              //   children: [
              //     Image.asset(
              //       "assets/images/clock.png",
              //       height: height * 82,
              //       width: width * 82,
              //     ),
              //     Positioned.fill(
              //         child: Align(
              //       alignment: Alignment.center,
              //       child: Transform.rotate(
              //         origin: const Offset(0, 0.5),
              //         angle: (2 * pi / 12) * cubit.now.hour +
              //             (2 * pi / 720) * cubit.now.minute,
              //         child: Container(
              //           height: height * 30,
              //           width: width * 2,
              //           decoration: BoxDecoration(
              //             color: Colors.black,
              //             borderRadius: BorderRadius.circular(width * 2),
              //           ),
              //         ),
              //       ),
              //     )),
              //     Positioned.fill(
              //       child: Align(
              //         alignment: const Alignment(-0.2, -0.25),
              //         child: Transform.rotate(
              //           angle: (2 * pi / 60) * cubit.now.minute,
              //           child: Container(
              //             height: height * 40,
              //             width: width * 2,
              //             decoration: BoxDecoration(
              //               color: Colors.black,
              //               borderRadius: BorderRadius.circular(width * 2),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        );
      },
    );
  }
}
