import 'package:flutter/material.dart';
import 'heatmap.dart';

Map<String, Function> getSampleWidget() {
  return <String, Function>{

  //  // Calendar Samples
  // 'getting_started_calendar': (Key key) => GettingStartedCalendar(key),
  // 'recurrence_calendar': (Key key) => RecurrenceCalendar(key),
  // 'agenda_view_calendar': (Key key) => AgendaViewCalendar(key),
  // 'appointment_editor_calendar': (Key key) => CalendarAppointmentEditor(key),
  // 'customization_calendar': (Key key) => CustomizationCalendar(key),
  // 'special_regions_calendar': (Key key) => SpecialRegionsCalendar(key),
  // 'schedule_view_calendar': (Key key) => ScheduleViewCalendar(key),
  // 'shift_scheduler': (Key key) => ShiftScheduler(key),
  // 'timeline_views_calendar': (Key key) => TimelineViewsCalendar(key),
  // 'air_fare_calendar': (Key key) => AirFareCalendar(key),

    // 'heat_map_calendar': (Key key) => HeatMapCalendar(key),
    'heat_map_calendar': (Key key) => HeatMapCalendar(),
  };
}