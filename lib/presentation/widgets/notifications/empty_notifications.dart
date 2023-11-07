import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/labels.dart';
import '../../assets/color_manager.dart';

class EmptyNotificationsWidget extends StatelessWidget {
  const EmptyNotificationsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          "assets/icons/empty_notifications.svg",
        ),
        SizedBox(
          height: width * 20,
        ),
        Text(
          'Empty',
          style: TextStyle(
            color: primaryColor,
            fontSize: textSize * 24,
            fontFamily: 'SFPro',
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: width * 10,
        ),
        Text(
          'There are no notifications.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFFAEACB9),
            fontSize: textSize * 14,
            fontFamily: 'SF Pro Display',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
