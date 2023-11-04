import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
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
    _titleController.text = note.title ?? 'Note Title';
    _descriptionController.text = note.description ??
        'lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur Excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is DeleteNoteSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Note deleted successfully',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: textSize * 14,
                  fontFamily: 'SFPro',
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: primaryColor,
              duration: const Duration(seconds: 2),
            ),
          );
          Navigator.of(context).pop();
        }
        if (state is DeleteNoteErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Error deleting note',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: textSize * 14,
                  fontFamily: 'SFPro',
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: primaryColor,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  top: width * 50,
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
                                  categoriesIcons[cubit
                                          .selectedNote!.categoryId ??
                                      Random().nextInt(categoriesIcons.length)],
                                  width: width * 24,
                                  height: height * 24,
                                ),
                                SizedBox(
                                  width: width * 8,
                                ),
                                Text(
                                  categoriesLabels[cubit
                                          .selectedNote!.categoryId ??
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
                              cubit.selectedNote!.updatedAt != null
                                  ? DateFormat("dd MMMM , yyyy At hh:mm a")
                                      .format(cubit.selectedNote!.updatedAt!)
                                  : '15 March , 2023 at 07:00 Am',
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
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
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
                    Expanded(
                      child: TextField(
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
                        controller: _descriptionController,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: 2,
                        maxLines: 100,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: textSize * 14,
                          fontFamily: 'SFPro',
                          fontWeight: FontWeight.w600,
                        ),
                        decoration:
                            const InputDecoration.collapsed(hintText: ""),
                      ),
                    ),
                    SizedBox(
                      height: height * 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            cubit.updateNote(
                                note: cubit.selectedNote!
                                    .copyWith(isImportant: true));
                          },
                          child: Container(
                            padding: EdgeInsets.all(width * 11),
                            decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: OvalBorder(),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x26000000),
                                  blurRadius: 20,
                                  offset: Offset(0, 0),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/bookmark_filled.svg",
                              width: width * 24,
                              height: height * 24,
                              colorFilter: const ColorFilter.mode(
                                primaryColor,
                                BlendMode.srcATop,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            cubit.deleteNote(noteId: cubit.selectedNote!.id!);
                          },
                          child: Container(
                            padding: EdgeInsets.all(width * 11),
                            decoration: const ShapeDecoration(
                              color: primaryColor,
                              shape: OvalBorder(),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x26000000),
                                  blurRadius: 20,
                                  offset: Offset(0, 0),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/trash.svg",
                              width: width * 24,
                              height: height * 24,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcATop,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(width * 11),
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: OvalBorder(),
                            shadows: [
                              BoxShadow(
                                color: Color(0x26000000),
                                blurRadius: 20,
                                offset: Offset(0, 0),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Icon(
                            Icons.share,
                            color: primaryColor,
                            size: width * 24,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 16,
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
