import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:smart_work/utils/constants/labels.dart';

import '../../utils/constants/images.dart';
import '../widgets/home/icon_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = '/home_screen';

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
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
      ),
    );
  }
}

class MainBanner extends StatelessWidget {
  const MainBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: width * 16, vertical: height * 24),
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
                DateFormat("h:mm a").format(DateTime.now()),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: textSize * 25.02,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: height * 6),
              Text(
                DateFormat("EEEE, dd MMMM yyyy").format(
                  DateTime.now(),
                ),
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
                '5 Tasks',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: textSize * 12.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          Image.asset(
            "assets/images/clock.png",
            height: height * 82,
            width: width * 82,
          ),
        ],
      ),
    );
  }
}

class HomeItemTile extends StatelessWidget {
  const HomeItemTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 8,
        vertical: height * 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(width * 22),
            decoration: ShapeDecoration(
              color: const Color(0xFFF7F5FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  width * 8,
                ),
              ),
            ),
            child: SvgPicture.asset(
              "assets/icons/types/education.svg",
            ),
          ),
          SizedBox(
            width: width * 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    "assets/icons/stopwatch.svg",
                    width: width * 8,
                    height: height * 10,
                  ),
                  SizedBox(
                    width: width * 8,
                  ),
                  Text(
                    '02:00 PM',
                    style: TextStyle(
                      color: const Color(0x5E242041),
                      fontSize: textSize * 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // const Spacer(),
                ],
              ),
              SizedBox(
                height: height * 10,
              ),
              Text(
                'Studying Math',
                style: TextStyle(
                  color: const Color(0xFF242041),
                  fontSize: textSize * 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: height * 16,
              ),
              SizedBox(
                width: width * 220,
                child: LinearProgressBar(
                  progress: 0.5,
                  borderRadius: width * 3,
                  height: height * 3,
                  backgroundColor: const Color(0xffDBDBDB),
                  progressColor: primaryColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          SvgPicture.asset(
            "assets/icons/bookmark.svg",
            width: width * 16,
            height: height * 16,
          )
        ],
      ),
    );
  }
}

class LinearProgressBar extends StatefulWidget {
  final double progress;
  final double borderRadius;
  final double height;
  final Color backgroundColor;
  final Color progressColor;

  const LinearProgressBar({
    super.key,
    this.progress = 0.0,
    this.borderRadius = 0.0,
    this.height = 10.0,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.blue,
  });

  @override
  State<LinearProgressBar> createState() => _LinearProgressBarState();
}

class _LinearProgressBarState extends State<LinearProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double progress = 0.0;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();
    updateProgress();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void updateProgress() {
    setState(() {
      progress = widget.progress;
    });
    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: FractionallySizedBox(
        alignment: "en" == "en" ? Alignment.centerLeft : Alignment.centerRight,
        widthFactor: progress,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            color: widget.progressColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          duration: const Duration(seconds: 3),
        ),
      ),
    );
  }
}
