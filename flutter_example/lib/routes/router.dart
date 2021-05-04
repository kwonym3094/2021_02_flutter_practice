import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_example/main.dart';
import 'package:flutter_example/pages/error.dart';
import 'package:flutter_example/pages/fourth.dart';
import 'package:flutter_example/pages/fourth_plus.dart';
import 'package:flutter_example/pages/fourth_second.dart';
import 'package:flutter_example/pages/fourth_third.dart';
import 'package:flutter_example/pages/second.dart';
import 'package:flutter_example/pages/third.dart';

@CupertinoAutoRouter(replaceInRouteName: 'Page,Route', routes: [
  CustomRoute(
      path: '/third/:userName/:points',
      page: ThirdPage,
      transitionsBuilder: TransitionsBuilders.zoomIn),
  AutoRoute(page: InitialPage, initial: true),
  AutoRoute(path: '/second/:userId', page: SecondPage),
  AutoRoute(path: '/fourth', page: FourthPage),
  AutoRoute(path: '/fourth-second', page: FourthSecondPage),
  AutoRoute(path: '/fourth-third', page: FourthThirdPage),
  AutoRoute(path: '/fourth-plus', page: FourthPlusPage),
  RedirectRoute(path: '/redirected', redirectTo: '/fourth'),
  AutoRoute(path: '/error', page: ErrorPage),
  RedirectRoute(path: '*', redirectTo: '/error'),
])
class $AppRouter {}
