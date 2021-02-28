import 'package:flutter/material.dart';

///calendar import
import 'package:syncfusion_flutter_calendar/calendar.dart';


/// Colors used as background color for various month cells in this sample
const Color _kLightGrey = Color.fromRGBO(238, 238, 238, 1);
const Color _kLightGreen = Color.fromRGBO(198, 228, 139, 1);
const Color _kMidGreen = Color.fromRGBO(123, 201, 111, 1);
const Color _kDarkGreen = Color.fromRGBO(35, 154, 59, 1);
const Color _kDarkerGreen = Color.fromRGBO(25, 97, 39, 1);

class CalendarSample extends StatefulWidget {
  @override
  _CalendarSampleState createState() => _CalendarSampleState();
}

class _CalendarSampleState extends State<CalendarSample> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50,),
        Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: _getHeatmapCalendar()),
      ],
    );
  }
}

SfCalendar _getHeatmapCalendar() {
  return SfCalendar(
    view: CalendarView.month,
    monthCellBuilder: _monthCellBuilder,
    showDatePickerButton: true,
    monthViewSettings: MonthViewSettings(
      showAgenda: true,
      showTrailingAndLeadingDates: true,
    ),
  );
}

/// Returns the cell  text color based on the cell background color
Color _getCellTextColor(Color backgroundColor) {
  if (backgroundColor == _kDarkGreen || backgroundColor == _kDarkerGreen) {
    return Colors.white;
  }

  return Colors.black;
}

Color _getCellTxtColor(Color backgroundColor) {
  if (backgroundColor == _kDarkerGreen || backgroundColor == _kDarkGreen) {
    return Colors.white;
  }
  return Colors.black;
}


Widget _monthCellBuilder(BuildContext context, MonthCellDetails details){
  final Color backgroundColor = _getMonthCellBackgroundColor(details.date);
  final defaultColor = Colors.white;

  return Container(
    decoration: BoxDecoration(
      color: backgroundColor,
      border: Border.all(color: defaultColor, width: 0.5)
    ),
    child: Center(
      child: Text(
        details.date.day.toString(),
        style: TextStyle(color: _getCellTxtColor(backgroundColor)),
      ),
    ),
  );
}


Color _getMonthCellBackgroundColor(DateTime date) {
  if (date.month % 2 == 0) {
    if (date.day % 6 == 0) {
      return _kDarkerGreen;
    } else if (date.day % 5 == 0) {
      return _kMidGreen;
    } else if (date.day % 8 == 0 || date.day % 4 == 0) {
      return _kDarkGreen;
    } else if (date.day % 9 == 0 || date.day % 3 == 0) {
      return _kLightGreen;
    } else if (date.day % 2 == 0) {
      return _kLightGrey;
    } else {
      return Colors.white;
    }
  } else {
    if (date.day % 6 == 0) {
      return _kMidGreen;
    } else if (date.day % 5 == 0) {
      return _kDarkGreen;
    } else if (date.day % 8 == 0 || date.day % 4 == 0) {
      return _kLightGreen;
    } else if (date.day % 9 == 0 || date.day % 3 == 0) {
      return _kLightGrey;
    } else if (date.day % 2 == 0) {
      return Colors.white;
    } else {
      return _kDarkerGreen;
    }
  }
}
