import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:smart_work/utils/constants/labels.dart';

class TaskTabBar extends StatefulWidget {
  const TaskTabBar({
    super.key,
    required this.tabController,
    required this.index,
  });

  final TabController tabController;
  final int index;

  @override
  State<TaskTabBar> createState() => _TaskTabBarState();
}

class _TaskTabBarState extends State<TaskTabBar> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Container(
          padding: EdgeInsets.all(width * 10),
          decoration: ShapeDecoration(
            color: const Color(0xFFF7F5FF),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: TabBar(
            onTap: (value) {
              setState(() {
                if (value == widget.index) return;
                if (value == 1) {
                  cubit.changeSelectedDate(
                    date: cubit.selectedDate!,
                  );
                } else if (value == 0) {
                  cubit.changeSelectedDate(
                    date: cubit.selectedDate!.add(
                      const Duration(days: -1),
                    ),
                  );
                } else {
                  cubit.changeSelectedDate(
                    date: cubit.selectedDate!.add(
                      const Duration(days: 1),
                    ),
                  );
                }
              });
            },
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
                      Text(
                        DateFormat('EEE').format(
                          cubit.selectedDate!.add(
                            const Duration(days: -1),
                          ),
                        ),
                        style: TextStyle(
                          color: widget.index == 0
                              ? const Color(0xFFC1B2FF)
                              : const Color(0xFF242041),
                          fontSize: textSize * 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: width * 4,
                      ),
                      Text(
                        cubit.selectedDate!
                            .add(
                              const Duration(days: -1),
                            )
                            .day
                            .toString(),
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
                      Text(
                        DateFormat('EEE').format(
                          cubit.selectedDate!,
                        ),
                        style: TextStyle(
                          color: widget.index == 1
                              ? const Color(0xFFC1B2FF)
                              : const Color(0xFF242041),
                          fontSize: textSize * 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: width * 4,
                      ),
                      Text(
                        cubit.selectedDate!.day.toString(),
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
                      Text(
                        DateFormat('EEE').format(
                          cubit.selectedDate!.add(
                            const Duration(days: 1),
                          ),
                        ),
                        style: TextStyle(
                          color: widget.index == 2
                              ? const Color(0xFFC1B2FF)
                              : const Color(0xFF242041),
                          fontSize: textSize * 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: width * 4,
                      ),
                      Text(
                        cubit.selectedDate!
                            .add(
                              const Duration(days: 1),
                            )
                            .day
                            .toString(),
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
      },
    );
  }
}
