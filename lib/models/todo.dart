import 'package:flutter_data/annotations.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/models/user.dart';

import 'adapters.dart';

part 'todo.g.dart';
part 'todo.freezed.dart';

@freezed
@DataRepository([StandardJSONAdapter, JSONPlaceholderAdapter])
abstract class Todo extends IdDataSupport<int, Todo> implements _$Todo {
  Todo._();
  factory Todo({
    int id,
    String title,
    @Default(false) bool completed,
    BelongsTo<User> user,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
