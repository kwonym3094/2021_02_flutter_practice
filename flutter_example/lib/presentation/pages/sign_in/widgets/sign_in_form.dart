// Flutter imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flash/flash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/application/auth/auth_bloc.dart';

// Project imports:
import 'package:flutter_example/application/auth/sign_in_form/sign_in_form_bloc.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
            () => {},
            (either) => either.fold(
                    (failure) async => {
                          // FlushbarHelper.createError(
                          //     message: failure.map(
                          //   cancelledByUser: (_) => 'Cancelled',
                          //   serverError: (_) => 'Server error',
                          //   emailAlreadyInUse: (_) => 'Email already in use',
                          //   invalidEmailAndPasswordCombination: (_) =>
                          //       'Invalid email and password combination',
                          // )).show(context)

                          await showFlash(
                              context: context,
                              duration: const Duration(seconds: 4),
                              builder: (context, controller) {
                                return Flash.bar(
                                    controller: controller,
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.8),
                                    position: FlashPosition.bottom,
                                    enableDrag: true,
                                    horizontalDismissDirection:
                                        HorizontalDismissDirection.horizontal,
                                    margin: const EdgeInsets.all(8),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    forwardAnimationCurve: Curves.easeOutBack,
                                    reverseAnimationCurve: Curves.easeOutBack,
                                    child: FlashBar(
                                      message: Text(failure.map(
                                        cancelledByUser: (_) => 'Cancelled',
                                        serverError: (_) => 'Server error',
                                        emailAlreadyInUse: (_) =>
                                            'Email already in use',
                                        invalidEmailAndPasswordCombination: (_) =>
                                            'Invalid email and password combination',
                                      )),
                                    ));
                              })
                        }, (_) {
                  AutoRouter.of(context).replaceNamed('/notes');
                  // authenticated state 도 바꿔줘야함
                  // 하지만 위의 BlocConsumer를 확인해보면 SignInFormBloc을 구독하고 있기 때문에 AuthBloc의 authenticated로 바꿔줄 수 없음
                  // 다음 방법 사용
                  context
                      .read<AuthBloc>()
                      .add(const AuthEvent.authCheckRequested());
                }));
      },
      builder: (context, state) {
        return Form(
          autovalidateMode: state.showErrorMessage,
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              const Text(
                '📒',
                style: TextStyle(fontSize: 130),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email), labelText: 'Email'),
                autocorrect: false,
                onChanged: (value) => context
                    .read<SignInFormBloc>()
                    .add(SignInFormEvent.emailChanged(value)),
                validator: (_) => context
                    .read<SignInFormBloc>()
                    .state
                    .emailAddress
                    .value
                    .fold(
                        (fail) => fail.maybeMap(
                            invalidEmail: (_) => 'Invalid Email',
                            orElse: () => null),
                        (_) => null),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Password',
                ),
                autocorrect: false,
                obscureText: true,
                onChanged: (value) => context
                    .read<SignInFormBloc>()
                    .add(SignInFormEvent.passwordChanged(value)),
                validator: (_) =>
                    context.read<SignInFormBloc>().state.password.value.fold(
                          (f) => f.maybeMap(
                            shortPassword: (_) => 'Short Password',
                            orElse: () => null,
                          ),
                          (_) => null,
                        ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                      child: TextButton(
                          onPressed: () {
                            context.read<SignInFormBloc>().add(
                                  const SignInFormEvent
                                      .signInWithEmailAndPasswordPressed(),
                                );
                          },
                          child: const Text('SIGN IN'))),
                  Expanded(
                      child: TextButton(
                          onPressed: () {
                            context.read<SignInFormBloc>().add(
                                  const SignInFormEvent
                                      .registerWithEmailAndPasswordPressed(),
                                );
                          },
                          child: const Text('REGISTER'))),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<SignInFormBloc>().add(
                        const SignInFormEvent.signInWithGooglePressed(),
                      );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue,
                  padding: const EdgeInsets.all(20.0),
                ),
                child: const Text(
                  'SIGN IN WITH GOOGLE',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              if (state.isSubmitting) ...[
                const SizedBox(height: 8),
                const LinearProgressIndicator(),
              ]
            ],
          ),
        );
      },
    );
  }
}
