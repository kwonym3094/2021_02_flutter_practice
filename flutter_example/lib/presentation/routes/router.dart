// Package imports:
import 'package:auto_route/annotations.dart';
import 'package:flutter_example/presentation/notes/note_form/note_form_page.dart';
import 'package:flutter_example/presentation/notes/notes_overview/notes_overview_page.dart';

// Project imports:
import 'package:flutter_example/presentation/pages/sign_in/sign_in_page.dart';
import 'package:flutter_example/presentation/pages/splash/splash_page.dart';

@CupertinoAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: SignInPage, path: '/signin'),
    AutoRoute(page: NotesOverviewPage, path: '/notes'),
    AutoRoute(
        page: NoteFormPage, path: '/notes/details', fullscreenDialog: true),
  ],
)
class $AppRouter {}
