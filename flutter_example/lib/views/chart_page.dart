import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class ChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30,),
        Container(
          height: 600,
            child: SfCalendar(
              view: CalendarView.month,
              firstDayOfWeek: 7,
              dataSource: MeetingDataSource(_getDataSource()),
              monthViewSettings: MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                showAgenda: true
              ),
            )
        ),
      ],
    );
  }

  List<Meeting> _getDataSource() {
    var meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(
        Meeting('Conference', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

// ---------
// // Example holidays
// final Map<DateTime, List> _holidays = {
//   DateTime(2020, 1, 1): ['New Year\'s Day'],
//   DateTime(2020, 1, 6): ['Epiphany'],
//   DateTime(2020, 2, 14): ['Valentine\'s Day'],
//   DateTime(2020, 4, 21): ['Easter Sunday'],
//   DateTime(2020, 4, 22): ['Easter Monday'],
// };
//
// class CalendarPage extends StatefulWidget {
//   @override
//   _CalendarPageState createState() => _CalendarPageState();
// }
//
// class _CalendarPageState extends State<CalendarPage> with SingleTickerProviderStateMixin{
//   Map<DateTime, List> _events;
//   List _selectedEvents;
//   AnimationController _animationController;
//   CalendarController _calendarController;
//
//   @override
//   void initState() {
//     super.initState();
//     final _selectedDay = DateTime.now();
//
//     _events = {
//       _selectedDay.subtract(Duration(days: 30)): [
//         'Event A0',
//         'Event B0',
//         'Event C0'
//       ],
//       _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
//       _selectedDay.subtract(Duration(days: 20)): [
//         'Event A2',
//         'Event B2',
//         'Event C2',
//         'Event D2'
//       ],
//       _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
//       _selectedDay.subtract(Duration(days: 10)): [
//         'Event A4',
//         'Event B4',
//         'Event C4'
//       ],
//       _selectedDay.subtract(Duration(days: 4)): [
//         'Event A5',
//         'Event B5',
//         'Event C5'
//       ],
//       _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
//       _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
//       _selectedDay.add(Duration(days: 1)): [
//         'Event A8',
//         'Event B8',
//         'Event C8',
//         'Event D8'
//       ],
//       _selectedDay.add(Duration(days: 3)):
//           Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
//       _selectedDay.add(Duration(days: 7)): [
//         'Event A10',
//         'Event B10',
//         'Event C10'
//       ],
//       _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
//       _selectedDay.add(Duration(days: 17)): [
//         'Event A12',
//         'Event B12',
//         'Event C12',
//         'Event D12'
//       ],
//       _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
//       _selectedDay.add(Duration(days: 26)): [
//         'Event A14',
//         'Event B14',
//         'Event C14'
//       ],
//     };
//
//     _selectedEvents = _events[_selectedDay] ?? [];
//     _calendarController = CalendarController();
//
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 400),
//     );
//
//     _animationController.forward();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _animationController.dispose();
//     _calendarController.dispose();
//   }
//
//   void _onDaySelected(DateTime day, List events, List holidays) {
//     print('CALLBACK: _onDaySelected');
//     setState(() {
//       _selectedEvents = events;
//     });
//   }
//
//   void _onVisibleDaysChanged(
//       DateTime first, DateTime last, CalendarFormat format) {
//     print('CALLBACK: _onVisibleDaysChanged');
//   }
//
//   void _onCalendarCreated(
//       DateTime first, DateTime last, CalendarFormat format) {
//     print('CALLBACK: _onCalendarCreated');
//   }
//
//   // simple tablecalendar configuration (using styles)
//   Widget _buildTableCalendar() {
//     return TableCalendar(
//       calendarController: _calendarController,
//       events: _events,
//       holidays: _holidays,
//       startingDayOfWeek: StartingDayOfWeek.sunday,
//       calendarStyle: CalendarStyle(
//         selectedColor: Colors.deepOrange[400],
//         todayColor: Colors.deepOrange[200],
//         markersColor: Colors.brown[700],
//         outsideDaysVisible: false,
//       ),
//       headerStyle: HeaderStyle(
//         formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
//         formatButtonDecoration: BoxDecoration(
//           color: Colors.deepOrange[400],
//           borderRadius: BorderRadius.circular(16.0),
//         )
//       ),
//       onDaySelected: _onDaySelected,
//       onVisibleDaysChanged: _onVisibleDaysChanged,
//       onCalendarCreated: _onCalendarCreated,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         _buildTableCalendar(),
//       ],
//     );
//   }
// }
