import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/ui/global/theme/app_themes.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_event.dart';
part 'theme_state.dart';
part 'theme_bloc.freezed.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeStat(themeData: appThemeData[AppTheme.GreenDark]!));

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    yield* event.map(themeChanged: (e) async* {
      yield ThemeState.themeStat(themeData: appThemeData[event.theme]!);
    });
  }
}
