import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import 'package:smart_work/domain/models/task.dart';
import 'package:smart_work/presentation/widgets/task/task_category.dart';
import '../../../config/themes/main_theme.dart';
import '../../../utils/constants/images.dart';
import '../../../utils/constants/labels.dart';
import '../../assets/color_manager.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});
  static const routeName = '/add-task';

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleController =
      TextEditingController(text: "New Task");
  TextEditingController descriptionController = TextEditingController();
  Duration? duration;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is AddTaskSuccessState) {
          Navigator.of(context).pop();
        }
        if (state is AddTaskErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                top: width * 50,
                left: width * 20,
                right: width * 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                            useSafeArea: true,
                            context: context,
                            builder: (context) => const AlertDialog(
                              backgroundColor: Colors.white,
                              contentPadding: EdgeInsets.zero,
                              content: PickTaskCategorySheet(),
                            ),
                          );
                        },
                        child: Container(
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
                            categoriesIcons[cubit.selectedTaskCategory],
                            width: width * 26,
                            height: height * 26,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 8,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              onTapOutside: (event) =>
                                  FocusScope.of(context).unfocus(),
                              controller: titleController,
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: primaryColor,
                                fontSize: textSize * 19,
                                fontFamily: 'SFPro',
                                fontWeight: FontWeight.w400,
                              ),
                              decoration:
                                  const InputDecoration.collapsed(hintText: ""),
                            ),
                            SizedBox(
                              height: height * 6,
                            ),
                            TextField(
                              onTapOutside: (event) =>
                                  FocusScope.of(context).unfocus(),
                              controller: descriptionController,
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: const Color(0xFFAEACB9),
                                fontSize: textSize * 14,
                                fontFamily: 'SFPro',
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: const InputDecoration.collapsed(
                                  hintText:
                                      "Add More info about time and date"),
                            )
                          ],
                        ),
                      ),
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
                  InkWell(
                    onTap: () async {
                      DateTime? date;
                      date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                          const Duration(days: 365),
                        ),
                      );
                      if (date != null) {
                        cubit.changeTaskDate(date: date);
                      }
                    },
                    child: Container(
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
                            cubit.pickedTaskDate != null
                                ? DateFormat("dd MMMM yyyy")
                                    .format(cubit.pickedTaskDate!)
                                : 'Date',
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
                            height: height * 24,
                            width: width * 24,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 24,
                  ),
                  InkWell(
                    onTap: () async {
                      TimeOfDay? time;
                      time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        cubit.changeTaskTime(time: time);
                      }
                    },
                    child: Container(
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
                            cubit.pickedTaskTime != null
                                ? cubit.pickedTaskTime!.format(context)
                                : 'Time',
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
                            height: height * 24,
                            width: width * 24,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 40,
                  ),
                  Text(
                    'Duration',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: textSize * 18,
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
                        setState(() {
                          duration = value;
                        });
                      },
                      mode: CupertinoTimerPickerMode.hms,
                    ),
                  ),
                  SizedBox(
                    height: height * 40,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: mainButtonTheme.style,
                      onPressed: () {
                        cubit.pickedTaskDate = DateTime(
                          cubit.pickedTaskDate!.year,
                          cubit.pickedTaskDate!.month,
                          cubit.pickedTaskDate!.day,
                          cubit.pickedTaskTime!.hour,
                          cubit.pickedTaskTime!.minute,
                        );
                        cubit.addTask(
                          task: Task(
                            title: titleController.text,
                            description: descriptionController.text,
                            finishTime: cubit.pickedTaskDate,
                            duration: duration!.inHours,
                            categoryId: cubit.selectedTaskCategory,
                          ),
                        );
                      },
                      child: AnimatedSize(
                        duration: const Duration(milliseconds: 400),
                        child: state is AddTaskLoadingState
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
                    ),
                  ),
                  SizedBox(
                    height: height * 40,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
