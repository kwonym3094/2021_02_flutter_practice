import 'package:freezed_annotation/freezed_annotation.dart'; // the reason why we import this : to make an object nicely readable in Flutter's devtool.

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  factory Todo({
    required int id,
    required String title,
    required String createdAt,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
