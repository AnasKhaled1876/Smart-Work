import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/labels.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height * 60,
        ),
        Text(
          '00:00',
          style: TextStyle(
            fontSize: textSize * 60,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
