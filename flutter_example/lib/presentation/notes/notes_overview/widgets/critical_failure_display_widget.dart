import 'package:flutter/material.dart';
import 'package:flutter_example/domain/notes/note_failure.dart';

class CriticalFailureDisplay extends StatelessWidget {
  final NoteFailure failure;

  const CriticalFailureDisplay({Key? key, required this.failure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '😱',
          style: TextStyle(fontSize: 100),
        ),
        Text(
          failure.maybeMap(
              insufficientPermission: (_) => 'Insufficient permissions',
              orElse: () => 'Unexpected error. \n Please contact support.'),
          style: const TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
        TextButton(
          onPressed: () {
            print('Sending Email!');
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.mail),
              const SizedBox(
                width: 4,
              ),
              const Text('I NEED HELP!'),
            ],
          ),
        ),
      ],
    ));
  }
}
