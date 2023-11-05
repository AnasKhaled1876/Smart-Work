import 'package:smart_work/presentation/widgets/task/task_tile.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import 'package:smart_work/domain/models/task.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_work/presentation/widgets/task/tab_bar.dart';
import '../../../utils/constants/labels.dart';
import '../../assets/color_manager.dart';
import 'package:flutter/material.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({super.key});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget>
    with SingleTickerProviderStateMixin {
  int index = 0;
  TextEditingController titleController = TextEditingController();
  @override
  void initState() {
    super.initState();
    AppCubit.get(context).tasksTabController =
        TabController(length: 3, vsync: this);
    AppCubit.get(context).tasksTabController!.addListener(() {
      setState(() {
        index = AppCubit.get(context).tasksTabController!.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Column(
          children: [
            TaskTabBar(tabController: cubit.tasksTabController!, index: index),
            SizedBox(
              height: height * 16,
            ),
            TextField(
              decoration: InputDecoration(
                fillColor: tertiaryColor,
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: width * 10, vertical: height * 14),
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: primaryColor,
                  fontSize: textSize * 14,
                  fontFamily: 'SFPro',
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  size: width * 24,
                  color: primaryColor,
                ),
              ),
            ),
            SizedBox(
              height: height * 16,
            ),
            SizedBox(
              height: height * 450,
              child: TabBarView(
                controller: cubit.tasksTabController,
                children: [
                  TaskList(
                      tasks: cubit.userProfile?.tasks
                              ?.where((element) =>
                                  !element.isArchived && !element.isImportant)
                              .toList() ??
                          []),
                  TaskList(
                      tasks: cubit.userProfile?.tasks
                              ?.where((element) => element.isImportant)
                              .toList() ??
                          []),
                  TaskList(
                      tasks: cubit.userProfile?.tasks
                              ?.where((element) => element.isArchived)
                              .toList() ??
                          []),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.tasks,
  });

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => InkWell(
        child: TaskTile(
          task: tasks[index],
        ),
      ),
    );
  }
}
