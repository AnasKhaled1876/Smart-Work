import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../domain/models/note.dart';
import '../../../utils/constants/images.dart';
import '../../../utils/constants/labels.dart';
import '../../assets/color_manager.dart';
import '../linear_progress_bar.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({
    super.key,
    required this.note,
  });
  final Note note;

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
              categoriesIcons[
                  note.categoryId ?? Random().nextInt(categoriesIcons.length)],
              width: width * 24,
              height: height * 24,
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
                    DateFormat("hh:mm a")
                        .format(note.finishTime ?? DateTime.now()),
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
                note.description ?? "No title",
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
