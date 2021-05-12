import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/post_service.dart';

enum NotifierState { initial, loading, loaded }

class PostChangeNotifier extends ChangeNotifier {
  final _postService = PostService();

  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;
  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  // Post _post;
  // Post get post => _post;
  // void _setPost(Post post) {
  //   _post = post;
  //   notifyListeners();
  // }

  // Failure _failure;
  // Failure get failure => _failure;
  // void _setFailure(Failure failure) {
  //   _failure = failure;
  //   notifyListeners();
  // }

  // Functional Programming에 맞춰 다음처럼 수정

  Either<Failure, Post> _post;
  Either<Failure, Post> get post => _post;

  void _setPost(Either<Failure, Post> post) {
    _post = post;
    notifyListeners();
  }

  void getOnePost() async {
    _setState(NotifierState.loading);
    // try {
    //   final post = await _postService.getOnePost();
    //   _setPost(post);
    // } on Failure catch (f) {
    //   _setFailure(f);
    // }
    // Functional Programming에 맞춰 다음처럼 수정

    await Task(() => _postService.getOnePost())
        // 자동으로 exceptions을 잡음
        .attempt()
        // 모든 exception을 처리하며 object로 형변환된 left를 다시 failure로 변환해줌
        // .map(
        //   (either) => either.leftMap((obj) {
        //     // 만약 에러가 뜰 경우를 고려해서 try catch 처리 => 다른 부분에서 다시 에러 잡을 것임
        //     try {
        //       return obj as Failure;
        //     } catch (e) {
        //       throw obj;
        //     }
        //   }),
        // )

        // 좀 더 짧게 줄이는 방법? => extension 사용!
        .mapLeftToFailure()

        // Task 를 Future로 변환
        .run()
        // 전통적인 Future 진행
        .then((value) => _setPost(value));
    _setState(NotifierState.loaded);
  }
}

// U는 아무거나 될 수 있음
extension TaskX<T extends Either<Object, U>, U> on Task<T> {
  Task<Either<Failure, U>> mapLeftToFailure() {
    return this.map((either) => either.leftMap((obj) {
          try {
            return obj as Failure;
          } catch (e) {
            throw obj;
          }
        }));
  }
}
