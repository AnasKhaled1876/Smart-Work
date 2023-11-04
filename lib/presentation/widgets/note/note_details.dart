import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import 'package:smart_work/domain/models/note.dart';

import '../../../utils/constants/images.dart';
import '../../../utils/constants/labels.dart';
import '../../assets/color_manager.dart';

class NoteDetailsScreen extends StatefulWidget {
  const NoteDetailsScreen({super.key});
  static const routeName = '/note-details';

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Note note = AppCubit.get(context).selectedNote!;
    _titleController.text = note.title ?? '';
    _descriptionController.text = note.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        Note note = AppCubit.get(context).selectedNote!;
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  top: width * 40,
                  left: width * 32,
                  right: width * 32,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  categoriesIcons[note.categoryId ??
                                      Random().nextInt(categoriesIcons.length)],
                                  width: width * 24,
                                  height: height * 24,
                                ),
                                SizedBox(
                                  width: width * 8,
                                ),
                                Text(
                                  categoriesLabels[note.categoryId ??
                                      Random().nextInt(categoriesIcons.length)],
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: textSize * 19,
                                    fontFamily: 'SFPro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 6,
                            ),
                            Text(
                              '15 March , 2023 at 07:00 Am',
                              style: TextStyle(
                                color: const Color(0xFFBDBDBD),
                                fontSize: textSize * 10,
                                fontFamily: 'SFPro',
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.all(width * 8),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
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
                            size: width * 24,
                            color: primaryColor,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 32,
                    ),
                    TextField(
                      controller: _titleController,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: textSize * 18,
                        fontFamily: 'SFPro',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration.collapsed(hintText: ""),
                    ),
                    SizedBox(
                      height: height * 16,
                    ),
                    TextField(
                      controller: _descriptionController,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: textSize * 14,
                        fontFamily: 'SFPro',
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: const InputDecoration.collapsed(hintText: ""),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
