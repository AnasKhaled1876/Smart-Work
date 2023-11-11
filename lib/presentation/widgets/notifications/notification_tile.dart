import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import '../../../utils/constants/labels.dart';
import '../../assets/color_manager.dart';

class NotificationDayTile extends StatelessWidget {
  const NotificationDayTile({
    super.key,
  });
  

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: height * 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: width * 5,
              ),
              Text(
                'Today'.i18n(),
                style: TextStyle(
                  color: primaryColor,
                  fontSize: textSize * 16.5,
                  fontFamily: 'SFPro',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 14,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => const NotificationTile(),
            itemCount: 3,
          )
        ],
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width * 5,
        ),
        Container(
          width: width * 35,
          height: width * 35,
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: OvalBorder(),
            shadows: [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 10,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: Icon(
            Icons.check,
            color: Colors.green,
            size: width * 20,
          ),
        ),
        SizedBox(
          width: width * 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Congratulations ! Task is Donedsa,fkc sdfgksdfg dyf gs',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: textSize * 13,
                        fontFamily: 'SFPro',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 40,
                  ),
                  Text(
                    '03:00 PM',
                    style: TextStyle(
                      color: const Color(0xFFAEACB9),
                      fontSize: textSize * 10,
                      fontFamily: 'SFPro',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * 8,
              ),
              Text(
                'Studying Math',
                style: TextStyle(
                  color: const Color(0xFFAEACB9),
                  fontSize: textSize * 10,
                  fontFamily: 'SFPro',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: height * 30,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
