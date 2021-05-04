// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../main.dart' as _i4;
import '../pages/error.dart' as _i10;
import '../pages/fourth.dart' as _i6;
import '../pages/fourth_plus.dart' as _i9;
import '../pages/fourth_second.dart' as _i7;
import '../pages/fourth_third.dart' as _i8;
import '../pages/second.dart' as _i5;
import '../pages/third.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    ThirdRoute.name: (routeData) {
      final args = routeData.argsAs<ThirdRouteArgs>();
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: _i3.ThirdPage(userName: args.userName, points: args.points),
          transitionsBuilder: _i1.TransitionsBuilders.zoomIn,
          opaque: true,
          barrierDismissible: false);
    },
    InitialRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: _i4.InitialPage());
    },
    SecondRoute.name: (routeData) {
      final args = routeData.argsAs<SecondRouteArgs>();
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: _i5.SecondPage(userId: args.userId));
    },
    FourthRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: _i6.FourthPage());
    },
    FourthSecondRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: _i7.FourthSecondPage());
    },
    FourthThirdRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: _i8.FourthThirdPage());
    },
    FourthPlusRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: _i9.FourthPlusPage());
    },
    ErrorRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: _i10.ErrorPage());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(ThirdRoute.name, path: '/third/:userName/:points'),
        _i1.RouteConfig(InitialRoute.name, path: '/'),
        _i1.RouteConfig(SecondRoute.name, path: '/second/:userId'),
        _i1.RouteConfig(FourthRoute.name, path: '/fourth'),
        _i1.RouteConfig(FourthSecondRoute.name, path: '/fourth-second'),
        _i1.RouteConfig(FourthThirdRoute.name, path: '/fourth-third'),
        _i1.RouteConfig(FourthPlusRoute.name, path: '/fourth-plus'),
        _i1.RouteConfig('/redirected#redirect',
            path: '/redirected', redirectTo: '/fourth', fullMatch: true),
        _i1.RouteConfig(ErrorRoute.name, path: '/error'),
        _i1.RouteConfig('*#redirect',
            path: '*', redirectTo: '/error', fullMatch: true)
      ];
}

class ThirdRoute extends _i1.PageRouteInfo<ThirdRouteArgs> {
  ThirdRoute({required String userName, required int points})
      : super(name,
            path: '/third/:userName/:points',
            args: ThirdRouteArgs(userName: userName, points: points));

  static const String name = 'ThirdRoute';
}

class ThirdRouteArgs {
  const ThirdRouteArgs({required this.userName, required this.points});

  final String userName;

  final int points;
}

class InitialRoute extends _i1.PageRouteInfo {
  const InitialRoute() : super(name, path: '/');

  static const String name = 'InitialRoute';
}

class SecondRoute extends _i1.PageRouteInfo<SecondRouteArgs> {
  SecondRoute({required String userId})
      : super(name,
            path: '/second/:userId', args: SecondRouteArgs(userId: userId));

  static const String name = 'SecondRoute';
}

class SecondRouteArgs {
  const SecondRouteArgs({required this.userId});

  final String userId;
}

class FourthRoute extends _i1.PageRouteInfo {
  const FourthRoute() : super(name, path: '/fourth');

  static const String name = 'FourthRoute';
}

class FourthSecondRoute extends _i1.PageRouteInfo {
  const FourthSecondRoute() : super(name, path: '/fourth-second');

  static const String name = 'FourthSecondRoute';
}

class FourthThirdRoute extends _i1.PageRouteInfo {
  const FourthThirdRoute() : super(name, path: '/fourth-third');

  static const String name = 'FourthThirdRoute';
}

class FourthPlusRoute extends _i1.PageRouteInfo {
  const FourthPlusRoute() : super(name, path: '/fourth-plus');

  static const String name = 'FourthPlusRoute';
}

class ErrorRoute extends _i1.PageRouteInfo {
  const ErrorRoute() : super(name, path: '/error');

  static const String name = 'ErrorRoute';
}
