// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:flutter_example/application/auth/auth_bloc.dart';
import 'package:flutter_example/presentation/injection.dart';
import 'package:flutter_example/presentation/routes/router.gr.dart';

class AppWidget extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          // getIt 으로 등록하므로 bloc 이 앱 모든 곳에서 사용할 수 있게 됨
          create: (context) =>
              // **중요패턴 : cascade operator 을 이용해서 instantiate 하고 바로 이벤트 추가하기 패턴
              getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()),
          // event 결과를 확인하기 위해서 auth state 를 listen할 수 있게 해줘야 함
          // 어디서 bloc을 체크하게 해줘야할까? => 이 페이지가 아니라 다른 "decision maker" 에서 체크해서 다른 페이지로 이동하게 결정 내려줘야 함
          // splash 페이지에서 처리하자
          // 밑에서 home: 을 지우고 auto route 를 사용하자
        )
      ],
      child: MaterialApp.router(
        title: 'Domain Driven Development Tutorial',
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
        // home: SignInPage(),
        theme: ThemeData.light().copyWith(
            primaryColor: Colors.green[800],
            accentColor: Colors.blueAccent,
            inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)))),
      ),
    );
  }
}
