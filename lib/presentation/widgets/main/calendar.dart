import 'package:smart_work/presentation/widgets/calendar/tab_bar.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:smart_work/domain/models/events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/cubit/app_cubit.dart';
import 'package:flutter/material.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget>
    with TickerProviderStateMixin {
  int index = 1;
  @override
  void initState() {
    super.initState();
    AppCubit.get(context).taskTabController =
        TabController(length: 3, vsync: this, initialIndex: 1);
    AppCubit.get(context).calendarController = CalendarController();
    AppCubit.get(context).calendarController!.selectedDate = DateTime.now();
    AppCubit.get(context).selectedDate = DateTime.now();
    AppCubit.get(context).taskTabController!.addListener(() {
      setState(() {
        index = AppCubit.get(context).taskTabController!.index;
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
            TaskTabBar(tabController: cubit.taskTabController!, index: index),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.6,
              child: TabBarView(
                controller: cubit.taskTabController,
                children: [
                  SfCalendar(
                    controller: cubit.calendarController!,
                    view: CalendarView.day,
                  ),
                  SfCalendar(
                    controller: cubit.calendarController!,
                    dataSource: MeetingDataSource(
                      source: cubit.userProfile!.tasks!
                          .map(
                            (task) => Appointment(
                              startTime: task.finishTime!,
                              endTime: task.finishTime!
                                  .add(const Duration(hours: 1)),
                              subject: task.title!,
                              color: primaryColor,
                            ),
                          )
                          .toList(),
                    ),
                    timeSlotViewSettings: const TimeSlotViewSettings(
                        nonWorkingDays: <int>[
                          DateTime.friday,
                          DateTime.saturday
                        ]),
                    view: CalendarView.day,
                  ),
                  SfCalendar(
                    controller: cubit.calendarController!,
                    view: CalendarView.day,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
