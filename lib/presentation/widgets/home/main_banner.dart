import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:smart_work/utils/constants/labels.dart';

class MainBanner extends StatelessWidget {
  const MainBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: width * 16, vertical: height * 24),
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
          //TODO: refresh time every minute
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat("h:mm a").format(DateTime.now()),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: textSize * 25.02,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: height * 6),
              Text(
                DateFormat("EEEE, dd MMMM yyyy").format(
                  DateTime.now(),
                ),
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
                '5 Tasks',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: textSize * 12.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          //TODO: Fix Clock Image to real clock with cogs
          Image.asset(
            "assets/images/clock.png",
            height: height * 82,
            width: width * 82,
          ),
        ],
      ),
    );
  }
}
