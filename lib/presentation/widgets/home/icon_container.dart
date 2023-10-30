import 'package:flutter/material.dart';
import 'package:smart_work/utils/constants/labels.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({
    super.key,
    required this.child, required this.onTap,
  });

  final Widget child;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(width * 16),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(width * 4)),
          shadows: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 20,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        child: child,
      ),
    );
  }
}
