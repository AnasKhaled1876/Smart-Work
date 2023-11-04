import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import 'package:smart_work/domain/models/note.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:smart_work/utils/constants/images.dart';

import '../../../utils/constants/labels.dart';

class AddNoteSheet extends StatefulWidget {
  const AddNoteSheet({
    super.key,
  });

  @override
  State<AddNoteSheet> createState() => _AddNoteSheetState();
}

class _AddNoteSheetState extends State<AddNoteSheet> {
  TextEditingController titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is AddNoteSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Note Added Successfully",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: textSize * 16,
                  fontFamily: 'SFPro',
                  fontWeight: FontWeight.w500,
                ),
              ),
              backgroundColor: primaryColor,
              duration: const Duration(milliseconds: 700),
            ),
          );
          Navigator.pop(context, true);
        }
        if (state is AddNoteErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: textSize * 16,
                  fontFamily: 'SFPro',
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: primaryColor,
              duration: const Duration(milliseconds: 700),
            ),
          );
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return badge.Badge(
          badgeContent: InkWell(
            onTap: () => Navigator.pop(context, false),
            child: Icon(
              Icons.close,
              color: Colors.white,
              size: width * 20,
            ),
          ),
          position:
              badge.BadgePosition.topEnd(top: height * -14, end: width * 16),
          badgeStyle: badge.BadgeStyle(
            elevation: 0,
            padding: EdgeInsets.all(width * 4),
            borderSide: BorderSide(
              color: Colors.white,
              width: width * 3,
            ),
            shape: badge.BadgeShape.circle,
            badgeColor: primaryColor,
            borderRadius: BorderRadius.circular(width * 10),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(width * 16),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: width * 32,
              vertical: height * 40,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: titleController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter a Title',
                        hintStyle: TextStyle(
                          color: primaryColor.withOpacity(0.6),
                          fontSize: textSize * 16,
                          fontFamily: 'SFPro',
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: width * 2,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: textSize * 23,
                        fontFamily: 'SFPro Display',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: height * 32,
                    ),
                    SizedBox(
                      child: Text(
                        'Choose The Category',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: textSize * 16,
                          fontFamily: 'SFPro Display',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 40,
                    ),
                    SizedBox(
                      height: height * 350,
                      width: MediaQuery.sizeOf(context).width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: categoriesIcons.length,
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                          margin: EdgeInsets.only(bottom: height * 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                categoriesIcons[index],
                                height: width * 18,
                                width: width * 18,
                              ),
                              SizedBox(
                                width: width * 16,
                              ),
                              Text(
                                categoriesLabels[index],
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: textSize * 17,
                                  fontFamily: 'SFPro',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              Checkbox(
                                shape: const CircleBorder(),
                                activeColor: primaryColor,
                                value: cubit.selectedNoteCategory == index,
                                onChanged: (check) {
                                  cubit.pickNoteCategory(index);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 32,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(width * 10),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 32,
                                vertical: height * 16,
                              ),
                            ),
                            onPressed: state is AddNoteLoadingState
                                ? () {}
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      cubit.addNote(
                                        note: Note(
                                          title: titleController.text,
                                          description: categoriesLabels[
                                              cubit.selectedNoteCategory],
                                          categoryId:
                                              cubit.selectedNoteCategory,
                                        ),
                                      );
                                    }
                                  },
                            child: state is AddNoteLoadingState
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: width * 2,
                                  )
                                : Text(
                                    "Done",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: textSize * 16,
                                      fontFamily: 'SFPro',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                      ],
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
