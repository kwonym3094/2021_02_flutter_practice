import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// HookWidget : 그냥 bool 값을 할당하는 대신 useState(false); 이런식으로 넣어서 활용할 수 있음.
//  setState 대신 활용할 수 있어서 코드가 줄어듬
class UnCompletedSwitch extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final toggleState = useState(false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: InkResponse(
        onTap: () {
          toggleState.value = !toggleState.value;
          context.read<NoteWatcherBloc>().add(toggleState.value
              ? const NoteWatcherEvent.watchUnCompletedStarted()
              : const NoteWatcherEvent.watchAllStarted());
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: toggleState.value
              ? const Icon(Icons.check_box_outline_blank, key: Key('outline'))
              : const Icon(Icons.indeterminate_check_box,
                  key: Key('indeterminate')),
        ),
      ),
    );
  }
}
