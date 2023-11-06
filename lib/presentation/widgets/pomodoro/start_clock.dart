import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:smart_work/utils/constants/labels.dart';

class StartClock extends StatelessWidget {
  const StartClock({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/clock_ticks.png",
          height: height * 210,
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
    );
  }
}
