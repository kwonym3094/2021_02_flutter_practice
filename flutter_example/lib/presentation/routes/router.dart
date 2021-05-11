// Package imports:
import 'package:auto_route/annotations.dart';

// Project imports:
import 'package:flutter_example/presentation/pages/sign_in/sign_in_page.dart';
import 'package:flutter_example/presentation/pages/splash/splash_page.dart';

@CupertinoAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: SignInPage, initial: true),
    AutoRoute(path: '/splash', page: SplashPage),
  ],
)
class $AppRouter {}
