import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// void main() {
//   runApp(ProviderScope(
//       child:
//           NestedDepedencyPage())); // RiverpodOnly())); // MyApp())); // 값을 사용하기 위해 ProviderScope 로 싸줌
// }

final greetingProvider =
    Provider((ref) => 'Hello Riverpod!'); // only definition is global !
// 정의된 것을 사용하는 클래스 안에서는 local 로 존재함 => 즉, class가 dispose 될 때 instance도 같이 dispose 됨 !
// 그냥 Provider와는 다르게 ChangeNotifierProvider 는 값이 바뀔 때 rebuild 됨
final incrementProvider = ChangeNotifierProvider((ref) => IncrementNotifier());

// ** Provider는 할 수 없고 Riverpod 만 할 수 있는 것 => 두 가지 이상 Inherit 하기 (RiverPodOnly Widget 확인하기)
final firstStringProvider = Provider((ref) => 'First');
final secondStringProvider = Provider((ref) => 'Second');

// 값을 사용하는 방법 1: StatelessWidget -> ConsumerWidget (build 할 때 ScopedReader을 추가해야함)
// 값을 사용하는 방법 2: StatelessWidget 변경 하지 않고 Consumer 사용
class RiverpodBasic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //, ScopedReader watch) {
    // ScopedReader will watch Provider and rebuild when Provider changes
    // final greeting = watch(greetingProvider);
    return MaterialApp(
      title: 'Riverpod Tutorial',
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Consumer(builder: (context, watch, child) {
            // final greeting = watch(greetingProvider);
            // return Text(greeting);
            // watch(...) 를 하지 않고 하는 사용하는 방법은? (build method 안에 없는 경우도 많기 때문)
            // - 밑의 예제 참고
            final incrementNotifier = watch(incrementProvider);
            return Text(incrementNotifier.value.toString());
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // 여기서는 watch 를 받지 않는데 어떻게 사용하는가? => context.read(-provider).-method()
            context.read(incrementProvider).increment();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class RiverpodOnly extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final first = watch(firstStringProvider);
    final second = watch(secondStringProvider);
    // final third = watch(myCustomProvider); // 없는 provider는 compile time error를 만듬 ! => 에러 발생 확률을 줄임

    return MaterialApp(
      title: 'Riverpod Tutorial',
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Text(first),
            Text(second),
          ],
        ),
      ),
    );
  }
}

class IncrementNotifier extends ChangeNotifier {
  int _value = 0;
  int get value => _value;
  void increment() {
    _value++;
    notifyListeners();
  }
}

// 현실에서는 depedency에 depedency를 물고 있는 구조를 많이 볼 수 있음 => Riverpod 에선 어떻게 문제를 해결하나?
class FakeHttpClient {
  Future<String> get(String url) async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Response from $url';
  }
}

final fakeHttpProvider = Provider((ref) => FakeHttpClient());
// final responseProvider = FutureProvider<String>((ref) async {
//   final httpClient =
//       ref.read(fakeHttpProvider); // read 말고 watch 쓸 수 있음(provider value 가 바뀔 때)
//   return httpClient.get('https://resocoder.com');
// });
// custom 값을 user 가 넣고 싶을 때? FutureProvider.family !
// autoDispose : dispose 할 필요는 없을 수도 있지만 필요할 때 사용하면 됨
final responseProvider =
    FutureProvider.autoDispose.family<String, String>((ref, url) async {
  final httpClient =
      ref.read(fakeHttpProvider); // read 말고 watch 쓸 수 있음(provider value 가 바뀔 때)
  return httpClient.get(url);
});

class NestedDepedencyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Tutorial',
      home: Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Consumer(
              builder: (context, watch, child) {
                // 이 패키지의 가장 아름다운 기능
                final responseAsyncValue = watch(responseProvider(
                    'https://resocoder.com test')); // AsyncValue => Union Type =>
                return responseAsyncValue.map(
                  data: (_) => Text(_.value),
                  loading: (_) => const CircularProgressIndicator(),
                  error: (_) => Text(
                    _.error.toString(),
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              },
            ),
          )),
    );
  }
}
