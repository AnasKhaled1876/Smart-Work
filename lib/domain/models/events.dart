import 'package:syncfusion_flutter_calendar/calendar.dart';

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource({required List<Appointment> source}) {
    appointments = source;
  }
}
