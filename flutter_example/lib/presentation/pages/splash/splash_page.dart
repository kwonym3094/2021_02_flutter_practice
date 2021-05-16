// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:flutter_example/application/auth/auth_bloc.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // BlocListener : build 동안 할 수 없는 것들을 하기에 유용함
    //  ex. navigation
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.map(
          // initial 일 때는 아무것도 발생하지 않음
          initial: (_) {},
          authenticated: (_) {
            AutoRouter.of(context).replaceNamed('/notes');
          },
          unauthenticated: (_) {
            AutoRouter.of(context).replaceNamed('/signin');
          },
        );
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
