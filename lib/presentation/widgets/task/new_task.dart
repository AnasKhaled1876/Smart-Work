import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import 'package:smart_work/domain/models/task.dart';
import '../../../config/themes/main_theme.dart';
import '../../../utils/constants/labels.dart';
import '../../assets/color_manager.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleController =
      TextEditingController(text: "New Task");
  TextEditingController descriptionController =
      TextEditingController(text: "Add More info about time and date");
  int? duration;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                top: width * 50,
                left: width * 20,
                right: width * 20,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: titleController,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: textSize * 19,
                              fontFamily: 'SFPro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: height * 6,
                          ),
                          TextField(
                            controller: descriptionController,
                            style: TextStyle(
                              color: const Color(0xFFAEACB9),
                              fontSize: textSize * 12,
                              fontFamily: 'SFPro',
                              fontWeight: FontWeight.w400,
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
                    height: height * 40,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 24, vertical: width * 16),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF7F5FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width * 8),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Date',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: textSize * 16,
                            fontFamily: 'SFPro',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          'assets/icons/calendar.svg',
                          colorFilter: const ColorFilter.mode(
                            primaryColor,
                            BlendMode.srcIn,
                          ),
                          height: height * 18,
                          width: width * 18,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 24,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 24, vertical: width * 16),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF7F5FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width * 8),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Time',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: textSize * 16,
                            fontFamily: 'SFPro',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          'assets/icons/time.svg',
                          colorFilter: const ColorFilter.mode(
                            primaryColor,
                            BlendMode.srcIn,
                          ),
                          height: height * 18,
                          width: width * 18,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 40,
                  ),
                  Text(
                    'Duration',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: textSize * 16,
                      fontFamily: 'SFPro',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: height * 16,
                  ),
                  Expanded(
                    child: CupertinoTimerPicker(
                      onTimerDurationChanged: (value) {
                        
                      },
                      mode: CupertinoTimerPickerMode.hms,
                    ),
                  ),
                  SizedBox(
                    height: height * 40,
                  ),
                  ElevatedButton(
                    style: mainButtonTheme.style,
                    onPressed: () {
                      cubit.addTask(
                        task: Task(
                          title: titleController.text,
                          description: descriptionController.text,
                          finishTime: DateTime.now(),
                          duration: 0,
                        ),
                      );
                    },
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 400),
                      child: state is RegisterUserLoadingState
                          ? const CircularProgressIndicator()
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Get Started',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: textSize * 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                SvgPicture.asset(
                                  "assets/icons/arrow_right.svg",
                                  width: width * 24,
                                  height: height * 24,
                                ),
                              ],
                            ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
