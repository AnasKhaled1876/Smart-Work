import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localization/localization.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import '../../utils/constants/images.dart';
import '../../utils/constants/labels.dart';
import '../../utils/constants/routes.dart';
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
              left: locale.languageCode == "en" ? width * -18 : null,
              right: locale.languageCode == "ar" ? width * -18 : null,
              child: Transform.flip(
                flipX: locale.languageCode == "ar" ? true : false,
                child: Image.asset(
                  "assets/images/drawer_circle.png",
                ),
              ),
            ),
            Positioned(
              top: height * 90,
              left: locale.languageCode == "en" ? width * 15 : null,
              right: locale.languageCode == "ar" ? width * 15 : null,
              child: Image.asset(
                "assets/images/logo_icon.png",
                width: width * 60,
                height: height * 60,
              ),
            ),
            Positioned(
              top: height * 200,
              left: locale.languageCode == "ar" ? 0 : width * 20,
              right: locale.languageCode == "ar" ? width * 20 : 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'App'.i18n(),
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
                                appLabels[index].i18n(),
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
                    'About'.i18n(),
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
                      itemBuilder: (context, index) => InkWell(
                        splashColor: Colors.transparent,
                        onTap: () =>
                            Navigator.pushNamed(context, aboutRoutes[index]),
                        child: Container(
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
                                aboutLabels[index].i18n(),
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
