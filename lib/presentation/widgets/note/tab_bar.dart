import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:smart_work/utils/constants/labels.dart';

class NoteTabBar extends StatefulWidget {
  const NoteTabBar({
    super.key,
    required this.tabController,
    required this.index,
  });

  final TabController tabController;
  final int index;

  @override
  State<NoteTabBar> createState() => _NoteTabBarState();
}

class _NoteTabBarState extends State<NoteTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(width * 10),
      decoration: ShapeDecoration(
        color: const Color(0xFFF7F5FF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: TabBar(
        labelPadding: EdgeInsets.symmetric(horizontal: width * 0),
        dividerColor: Colors.transparent,
        indicatorWeight: 0.1,
        indicatorColor: Colors.transparent,
        controller: widget.tabController,
        tabs: [
          Tab(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: widget.index == 0
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 8),
                      color: primaryColor,
                    )
                  : null,
              padding: EdgeInsets.symmetric(
                horizontal: width * 16,
                vertical: height * 12,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    child: SvgPicture.asset("assets/icons/app/notes.svg",
                        width: width * 18,
                        height: height * 18,
                        colorFilter: ColorFilter.mode(
                          widget.index == 0
                              ? const Color(0xFFC1B2FF)
                              : const Color(0xFF242041),
                          BlendMode.srcIn,
                        )),
                  ),
                  SizedBox(
                    width: width * 4,
                  ),
                  Text(
                    'All',
                    style: TextStyle(
                      color: widget.index == 0
                          ? const Color(0xFFC1B2FF)
                          : const Color(0xFF242041),
                      fontSize: textSize * 12,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
          Tab(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(
                horizontal: width * 16,
                vertical: height * 12,
              ),
              decoration: widget.index == 1
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 8),
                      color: primaryColor,
                    )
                  : null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset("assets/icons/bookmark.svg",
                      width: width * 18,
                      height: height * 18,
                      colorFilter: ColorFilter.mode(
                        widget.index == 1
                            ? const Color(0xFFC1B2FF)
                            : const Color(0xFF242041),
                        BlendMode.srcIn,
                      )),
                  SizedBox(
                    width: width * 4,
                  ),
                  Text(
                    'Important',
                    style: TextStyle(
                      color: widget.index == 1
                          ? const Color(0xFFC1B2FF)
                          : const Color(0xFF242041),
                      fontSize: textSize * 12,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
          Tab(
            child: AnimatedContainer(
              padding: EdgeInsets.symmetric(
                horizontal: width * 16,
                vertical: height * 12,
              ),
              decoration: widget.index == 2
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 8),
                      color: primaryColor,
                    )
                  : null,
              duration: const Duration(milliseconds: 300),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset("assets/icons/trash.svg",
                      width: width * 18,
                      height: height * 18,
                      colorFilter: ColorFilter.mode(
                        widget.index == 2
                            ? const Color(0xFFC1B2FF)
                            : const Color(0xFF242041),
                        BlendMode.srcIn,
                      )),
                  SizedBox(
                    width: width * 4,
                  ),
                  Text(
                    'Archived',
                    style: TextStyle(
                      color: widget.index == 2
                          ? const Color(0xFFC1B2FF)
                          : const Color(0xFF242041),
                      fontSize: textSize * 12,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
