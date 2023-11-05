import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import '../../../domain/models/note.dart';
import '../../../utils/constants/images.dart';
import '../../../utils/constants/labels.dart';
import 'note_details.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({
    super.key,
    required this.note,
  });
  final Note note;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Container(
          height: height * 60,
          margin: EdgeInsets.only(bottom: height * 22),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  cubit.selectedNote = note;
                  Navigator.pushNamed(
                    context,
                    NoteDetailsScreen.routeName,
                  );
                },
                child: Row(
                  children: [
                    Container(
                      height: height * 65,
                      padding: EdgeInsets.all(width * 18),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF7F5FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            width * 8,
                          ),
                        ),
                      ),
                      child: SvgPicture.asset(
                        categoriesIcons[note.categoryId ??
                            Random().nextInt(categoriesIcons.length)],
                        width: width * 26,
                        height: height * 26,
                      ),
                    ),
                    SizedBox(
                      width: width * 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          note.description ?? "No title",
                          style: TextStyle(
                            color: const Color(0xFF242041),
                            fontSize: textSize * 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: height * 8,
                        ),
                        SizedBox(
                          width: width * 233,
                          child: Text(
                            'Lorem ipsum dolor sit amet consectetur...',
                            style: TextStyle(
                              color: const Color(0x5E242041),
                              fontSize: textSize * 11,
                              fontFamily: 'SFPro',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  cubit.updateNote(
                    note: note.copyWith(
                      isImportant: !note.isImportant,
                    ),
                  );
                },
                child: SvgPicture.asset(
                  note.isImportant
                      ? "assets/icons/bookmark_filled.svg"
                      : "assets/icons/bookmark.svg",
                  width: width * 22,
                  height: height * 22,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
