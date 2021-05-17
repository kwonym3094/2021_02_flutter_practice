import 'package:auto_route/auto_route.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/application/auth/auth_bloc.dart';
import 'package:flutter_example/application/notes/note_actor/note_actor_bloc.dart';
import 'package:flutter_example/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:flutter_example/presentation/injection.dart';
import 'package:flutter_example/presentation/notes/notes_overview/widgets/notes_overview_body.dart';
import 'package:flutter_example/presentation/notes/notes_overview/widgets/uncompleted_switch.dart';
import 'package:flutter_example/presentation/routes/router.gr.dart';

class NotesOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteWatcherBloc>(
            create: (context) => getIt<NoteWatcherBloc>()
              ..add(const NoteWatcherEvent.watchAllStarted())),
        BlocProvider<NoteActorBloc>(
            create: (context) => getIt<NoteActorBloc>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(listener: (context, state) {
            // maybeMap : 우리가 관심있는것만 사용
            state.maybeMap(
                unauthenticated: (_) =>
                    AutoRouter.of(context).replaceNamed('/signin'),
                orElse: () {});
          }),
          BlocListener<NoteActorBloc, NoteActorState>(
              listener: (context, state) {
            state.maybeMap(
                deleteFailure: (state) async {
                  await showFlash(
                      context: context,
                      duration: const Duration(seconds: 4),
                      builder: (context, controller) {
                        return Flash.bar(
                            controller: controller,
                            backgroundColor: Colors.grey.withOpacity(0.8),
                            position: FlashPosition.bottom,
                            enableDrag: true,
                            horizontalDismissDirection:
                                HorizontalDismissDirection.horizontal,
                            margin: const EdgeInsets.all(8),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            forwardAnimationCurve: Curves.easeOutBack,
                            reverseAnimationCurve: Curves.easeOutBack,
                            child: FlashBar(
                              message: Text(state.noteFailure.map(
                                unexpected: (_) =>
                                    'Unexpected error occured while deleting, please contact support.',
                                insufficientPermission: (_) =>
                                    'Insufficient permission',
                                unableToUpdate: (_) => 'Impossible Error',
                              )),
                            ));
                      });
                },
                orElse: () {});
          })
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Notes'),
            leading: IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEvent.signedOut());
                // TODO: Implement function
              },
            ),
            actions: [UnCompletedSwitch()],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              AutoRouter.of(context).push(NoteFormRoute());
            },
            child: const Icon(Icons.add),
          ),
          body: NotesOverviewBody(),
        ),
      ),
    );
  }
}
