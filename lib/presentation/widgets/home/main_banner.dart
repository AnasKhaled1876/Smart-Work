import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:smart_work/utils/constants/labels.dart';

class MainBanner extends StatefulWidget {
  const MainBanner({
    super.key,
  });

  @override
  State<MainBanner> createState() => _MainBannerState();
}

class _MainBannerState extends State<MainBanner> {
  Timer? time;
  @override
  void initState() {
    super.initState();
    time = Timer.periodic(const Duration(seconds: 45), (timer) {
      AppCubit.get(context).refreshTime();
    });
  }

  @override
  void dispose() {
    time!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: width * 16, vertical: height * 24),
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
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat("h:mm a").format(cubit.now),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: textSize * 25.02,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: height * 6),
                  Text(
                    DateFormat("EEEE, dd MMMM yyyy").format(cubit.now),
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
                    '${cubit.userProfile!.tasks?.length ?? 0} Tasks',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: textSize * 12.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              //create a white wall clock with arrows that move according to the time

              Image.asset(
                "assets/images/clock.png",
                height: height * 82,
                width: width * 82,
              ),
            ],
          ),
        );
      },
    );
  }
}
