import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';

import '../../utils/constants/images.dart';
import '../../utils/constants/labels.dart';
import '../assets/color_manager.dart';

class AdvancedDrawerWidget extends StatelessWidget {
  const AdvancedDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: height * 30,
              left: width * -18,
              child: Image.asset(
                "assets/images/drawer_circle.png",
              ),
            ),
            Positioned(
              top: height * 90,
              left: width * 15,
              child: Image.asset(
                "assets/images/logo_icon.png",
                width: width * 60,
                height: height * 60,
              ),
            ),
            Positioned(
              top: height * 200,
              left: width * 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'App',
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: textSize * 14,
                      fontFamily: 'SFPro',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: height * 30,
                  ),
                  SizedBox(
                    width: width * 200,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 4,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.only(
                          bottom: height * 25,
                        ),
                        child: InkWell(
                          onTap: () {
                            if (index > 1) {
                              cubit.changeIndex(index + 1);
                            } else {
                              cubit.changeIndex(index);
                            }
                            cubit.advancedDrawerController.toggleDrawer();
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                appIcons[index],
                                width: width * 20,
                                height: height * 20,
                              ),
                              SizedBox(
                                width: width * 16,
                              ),
                              Text(
                                appLabels[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: textSize * 16,
                                  fontFamily: 'SFPro',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 30,
                  ),
                  Text(
                    'About',
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: textSize * 14,
                      fontFamily: 'SFPro',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: height * 30,
                  ),
                  SizedBox(
                    width: width * 200,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 4,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.only(
                          bottom: height * 25,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              aboutIcons[index],
                              width: width * 20,
                              height: height * 20,
                            ),
                            SizedBox(
                              width: width * 16,
                            ),
                            Text(
                              aboutLabels[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: textSize * 16,
                                fontFamily: 'SFPro',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
