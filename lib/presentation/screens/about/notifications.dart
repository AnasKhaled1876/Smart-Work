import 'package:smart_work/presentation/assets/color_manager.dart';
import '../../../utils/constants/labels.dart';
import 'package:flutter/material.dart';

import '../../widgets/notifications/notification_tile.dart';

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
