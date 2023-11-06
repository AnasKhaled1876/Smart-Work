import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';

import '../../../utils/constants/labels.dart';
import '../../assets/color_manager.dart';

class PomodoroClock extends StatelessWidget {
  const PomodoroClock({
    super.key,
  });

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
                    '00\t:\t00',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: textSize * 26.40,
                      fontFamily: 'SFPro',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
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
              ),
            )),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: width * 280,
                  height: width * 280,
                  child: CircularProgressIndicator(
                    strokeWidth: width * 2,
                    color: secondaryColor,
                    value: cubit.pomodoroTime / 60,
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
