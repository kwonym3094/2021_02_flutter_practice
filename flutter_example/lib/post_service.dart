import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

class FakeHttpClient {
  Future<String> getResponseBody() async {
    await Future.delayed(Duration(milliseconds: 500));
    //! No Internet Connection
    // throw SocketException('No Internet');
    //! 404
    // throw HttpException('404');
    //! Invalid JSON (throws FormatException)
    // return 'abcd';
    //! 아예 처리되지 않은 에러를 보내면?
    // throw FileSystemException();
    return '{"userId":1,"id":1,"title":"nice title","body":"cool body"}';
  }
}

class PostService {
  final httpClient = FakeHttpClient();
  Future<Post> getOnePost() async {
    // 최악의 에러 핸들링
    // The WORST type of error handling.
    // There's no way to get these error messages to the UI.
    // try {
    // main 에서 FutureBuilder 로 사용하고 있으니 try catch 문으로 처리하지 않아도 됨(futurebuilder 도 error 체크함)
    // } catch (e) {

    // }

    // 다음에서는 각각의 Exception 을 처리하는 방법을 다룸
    try {
      final responseBody = await httpClient.getResponseBody();
      return Post.fromJson(responseBody);
    } on SocketException {
      // custom exception을 넘겨준다
      throw Failure('No internet connection!');
    } on HttpException {
      throw Failure('Couldn\'t find the pose!');
    } on FormatException {
      throw Failure('Bad Response format!');
    }
  }
}

class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({
    @required this.id,
    @required this.userId,
    @required this.title,
    @required this.body,
  });

  static Post fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Post(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      body: map['body'],
    );
  }

  static Post fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post id: $id, userId: $userId, title: $title, body: $body';
  }
}
