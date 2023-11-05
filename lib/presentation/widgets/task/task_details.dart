import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import 'package:smart_work/presentation/widgets/task/task_category.dart';
import '../../../utils/constants/images.dart';
import '../../../utils/constants/labels.dart';
import '../../assets/color_manager.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key});
  static const routeName = '/task_details';

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Duration? duration;

  @override
  void initState() {
    super.initState();
    titleController.text = AppCubit.get(context).selectedTask!.title ?? '';
    descriptionController.text =
        AppCubit.get(context).selectedTask!.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is DeleteTaskSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: primaryColor,
              content: Text(
                'Task Deleted Successfully',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
          Navigator.of(context).pop();
        }
        if (state is DeleteTaskErrorState) {
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width * 8,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                  child: SvgPicture.asset(
                                    categoriesIcons[
                                        cubit.selectedTask!.categoryId ?? 0],
                                    width: width * 20,
                                    height: height * 20,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 12,
                                ),
                                Expanded(
                                  child: TextField(
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
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ""),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 6,
                            ),
                            Text(
                              DateFormat("dd MMMM, yyyy At hh:mm a")
                                  .format(cubit.selectedTask!.finishTime!),
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: const Color(0xFFAEACB9),
                                fontSize: textSize * 12,
                                fontFamily: 'SFPro',
                                fontWeight: FontWeight.w400,
                              ),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Studying Math',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: textSize * 16,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        "assets/icons/stopwatch.svg",
                        width: width * 14,
                        height: height * 14,
                      ),
                      SizedBox(
                        width: width * 8,
                      ),
                      Text(
                        DateFormat("hh:mm a").format(
                            cubit.selectedTask!.finishTime ?? DateTime.now()),
                        style: TextStyle(
                          color: const Color(0x5E242041),
                          fontSize: textSize * 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 17,
                  ),
                  Container(
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.8,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 100,
                  ),
                  SvgPicture.asset(
                    "assets/icons/cup.svg",
                    width: width * 160,
                    height: height * 160,
                  ),
                  SizedBox(
                    height: height * 18,
                  ),
                  Text(
                    'Congratulations !',
                    style: TextStyle(
                      color: const Color(0xFFC1B2FF),
                      fontSize: textSize * 24,
                      fontFamily: 'SFPro',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'You Have Finished The Task\nSuccessfully.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: textSize * 12,
                      fontFamily: 'SFPro',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Expanded(child: Container()),
                  const Divider(
                    color: Color(0xFFDBDBDB),
                    thickness: 0.8,
                  ),
                  SizedBox(
                    height: height * 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Mark As Important',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: textSize * 15.77,
                          fontFamily: 'SF Pro Text',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        "assets/icons/bookmark.svg",
                        width: width * 20,
                        height: height * 20,
                        colorFilter: const ColorFilter.mode(
                          primaryColor,
                          BlendMode.srcIn,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 25,
                  ),
                  const Divider(
                    color: Color(0xFFDBDBDB),
                    thickness: 0.8,
                  ),
                  SizedBox(
                    height: height * 20,
                  ),
                  InkWell(
                    onTap: () {
                      cubit.deleteTask(
                        taskId: cubit.selectedTask!.id!,
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'Delete',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: textSize * 15.77,
                            fontFamily: 'SF Pro Text',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          "assets/icons/trash.svg",
                          width: width * 20,
                          height: height * 20,
                        ),
                      ],
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
