import 'package:auto_route/annotations.dart';
import 'package:flutter_example/main.dart';
import 'package:flutter_example/src/riverpod_basic/riverpod_basic.dart';
import 'package:flutter_example/src/riverpod_state/presentation/weather_search_page.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: [
  AutoRoute(page: HomePage, initial: true),
  AutoRoute(page: RiverpodBasic),
  AutoRoute(page: WeatherSearchPage),
])
class $AppRouter {}
