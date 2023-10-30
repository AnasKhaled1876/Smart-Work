import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:smart_work/presentation/widgets/home/main_banner.dart';
import 'package:smart_work/utils/constants/labels.dart';
import '../../utils/constants/images.dart';
import '../widgets/home/home_item_tile.dart';
import '../widgets/home/icon_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AdvancedDrawerController advancedDrawerController =
      AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return AdvancedDrawer(
          controller: advancedDrawerController,
          backdropColor: primaryColor,
          openRatio: 0.4,
          openScale: 0.7,
          childDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(width * 16),
          ),
          drawer: Stack(
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
                left: width * 40,
                child: Image.asset(
                  "assets/images/logo_icon.png",
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
          ),
          child: Scaffold(
            extendBody: true,
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: primaryColor,
              ),
              toolbarHeight: 0,
            ),
            body: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * 16),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: width * 28,
                  vertical: height * 40,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconContainer(
                          onTap: () {
                            advancedDrawerController.showDrawer();
                          },
                          child: SvgPicture.asset(
                            'assets/icons/menu.svg',
                            colorFilter: const ColorFilter.mode(
                              Color(0xFF242041),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 16,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFFCCCCCC),
                                fontSize: textSize * 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: height * 2),
                            Text(
                              'Mr.Tareq',
                              style: TextStyle(
                                color: const Color(0xFF242041),
                                fontSize: textSize * 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconContainer(
                          onTap: () {},
                          child: SvgPicture.asset(
                            'assets/icons/bell.svg',
                            colorFilter: const ColorFilter.mode(
                              Color(0xFF242041),
                              BlendMode.srcIn,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: height * 40),
                    const MainBanner(),
                    SizedBox(height: height * 24),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'Today’s Tasks',
                            style: TextStyle(
                              color: const Color(0xFF242041),
                              fontSize: textSize * 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          'see all',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: const Color(0xFFC1B2FF),
                            fontSize: textSize * 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 14,
                    ),
                    ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => const HomeItemTile(),
                    )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              height: height * 90,
              padding: EdgeInsets.only(
                left: width * 28,
                right: width * 28,
                top: height * 20,
                bottom: height * 10,
              ),
              shape: AutomaticNotchedShape(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(width * 0),
                ),
                BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(width * 40),
                ),
              ),
              color: Colors.white,
              shadowColor: Colors.white,
              surfaceTintColor: Colors.white,
              elevation: 30,
              notchMargin: width * 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  5,
                  (index) => index == 2
                      ? SizedBox(
                          width: width * 20,
                        )
                      : BottomBarIcon(
                          iconPath:
                              bottomBarIcons[index > 2 ? index - 1 : index],
                          label: bottomBarLabels[index > 2 ? index - 1 : index],
                          picked: cubit.currentIndex == index,
                        ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: primaryColor,
              child: SvgPicture.asset(
                'assets/icons/stopwatch.svg',
                colorFilter: const ColorFilter.mode(
                  secondaryColor,
                  BlendMode.srcIn,
                ),
                width: width * 24,
                height: height * 24,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          ),
        );
      },
    );
  }
}

class BottomBarIcon extends StatelessWidget {
  const BottomBarIcon({
    super.key,
    required this.iconPath,
    required this.label,
    required this.picked,
  });
  final String iconPath, label;
  final bool picked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          iconPath,
          colorFilter: ColorFilter.mode(
            picked ? primaryColor : Color(0xffACAEBE),
            BlendMode.srcIn,
          ),
          width: width * 24,
          height: height * 24,
        ),
        SizedBox(
          height: height * 4,
        ),
        Text(
          label,
          style: TextStyle(
            color: picked ? primaryColor : Color(0xffACAEBE),
            fontSize: textSize * 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
