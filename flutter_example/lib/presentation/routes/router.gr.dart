// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../pages/sign_in/sign_in_page.dart' as _i3;
import '../pages/splash/splash_page.dart' as _i4;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SignInRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.SignInPage();
        }),
    SplashRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.SplashPage();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SignInRoute.name, path: '/'),
        _i1.RouteConfig(SplashRoute.name, path: '/splash')
      ];
}

class SignInRoute extends _i1.PageRouteInfo {
  const SignInRoute() : super(name, path: '/');

  static const String name = 'SignInRoute';
}

class SplashRoute extends _i1.PageRouteInfo {
  const SplashRoute() : super(name, path: '/splash');

  static const String name = 'SplashRoute';
}
