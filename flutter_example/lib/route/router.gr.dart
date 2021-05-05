// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../main.dart' as _i3;
import '../src/riverpod_basic/riverpod_basic.dart' as _i4;
import '../src/riverpod_state/presentation/weather_search_page.dart' as _i5;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.HomePage());
    },
    RiverpodBasic.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.RiverpodBasic());
    },
    WeatherSearchRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i5.WeatherSearchPage());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(HomeRoute.name, path: '/'),
        _i1.RouteConfig(RiverpodBasic.name, path: '/riverpod-basic'),
        _i1.RouteConfig(WeatherSearchRoute.name, path: '/weather-search-page')
      ];
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: '/');

  static const String name = 'HomeRoute';
}

class RiverpodBasic extends _i1.PageRouteInfo {
  const RiverpodBasic() : super(name, path: '/riverpod-basic');

  static const String name = 'RiverpodBasic';
}

class WeatherSearchRoute extends _i1.PageRouteInfo {
  const WeatherSearchRoute() : super(name, path: '/weather-search-page');

  static const String name = 'WeatherSearchRoute';
}
