import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_data_todos/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

import '_adapters.dart';

part 'todo.g.dart';

@JsonSerializable()
@CopyWith()
@DataRepository([JSONPlaceholderAdapter])
class Todo extends DataModel<Todo> {
  @override
  final int id;
  @JsonKey(name: 'title')
  final String description;
  final bool completed;
  @JsonKey(name: 'userId')
  late final BelongsTo<User> user;

  Todo({
    required this.id,
    required this.description,
    this.completed = false,
    BelongsTo<User>? user,
  }) : user = user ?? BelongsTo();

  @override
  String toString() =>
      'Todo(id: $id, text: $description, completed: $completed)';
}
