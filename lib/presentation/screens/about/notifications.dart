import 'package:smart_work/presentation/assets/color_manager.dart';
import '../../../utils/constants/labels.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  static const routeName = '/notifications';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 32,
            vertical: width * 47,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Notifications',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: textSize * 22,
                        fontFamily: 'SFPro',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(width * 10),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * 4),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x26000000),
                            blurRadius: 20,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Icon(
                        Icons.close,
                        color: primaryColor,
                        size: width * 24,
                      ),
                    ),
                  )
                ],
              ),
              // const Spacer(),
              // const EmptyNotificationsWidget(),

              SizedBox(
                height: height * 40,
              ),
              // TextField(
              //   decoration: InputDecoration(
              //     fillColor: const Color(0xFFF7F5FF),
              //     filled: true,
              //     contentPadding: EdgeInsets.symmetric(
              //         horizontal: width * 10, vertical: height * 14),
              //     hintText: 'Search',
              //     hintStyle: TextStyle(
              //       color: primaryColor,
              //       fontSize: textSize * 14,
              //       fontFamily: 'SFPro',
              //       fontWeight: FontWeight.w600,
              //     ),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //       borderSide: BorderSide.none,
              //     ),
              //     prefixIcon: Icon(
              //       Icons.search,
              //       size: width * 24,
              //       color: primaryColor,
              //     ),
              //     suffixIcon: Icon(
              //       Icons.mic,
              //       size: width * 22,
              //       color: primaryColor,
              //     ),
              //   ),
              // ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => const NotificationDayTile(),
                  itemCount: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
          Text(
            'Today',
            style: TextStyle(
              color: primaryColor,
              fontSize: textSize * 16.5,
              fontFamily: 'SFPro',
              fontWeight: FontWeight.w500,
            ),
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
      children: [
        SizedBox(
          width: width * 10,
        ),
        Container(
          padding: EdgeInsets.all(width * 10),
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
            size: width * 24,
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
                  Text(
                    'Congratulations ! Task is Done',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: textSize * 14,
                      fontFamily: 'SFPro',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '03:00 PM',
                    style: TextStyle(
                      color: const Color(0xFFAEACB9),
                      fontSize: textSize * 8,
                      fontFamily: 'SFPro',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * 10,
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
