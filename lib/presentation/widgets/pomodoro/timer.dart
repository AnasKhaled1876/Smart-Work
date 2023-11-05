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
        Expanded(
          //adjust the theme of the timepicker and make the text color white

          child: CupertinoTheme(
            data: const CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                pickerTextStyle: TextStyle(color: Colors.white),
              ),
            ),
            child: CupertinoPicker(
              itemExtent: 100,
              onSelectedItemChanged: (int value) {},
              children: [
                
              ],
            ),
          ),
        ),
      ],
    );
  }
}
