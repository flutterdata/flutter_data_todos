import 'package:flutter_data/flutter_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todos/models/user.dart';

import '_adapters.dart';

part 'todo.g.dart';

@JsonSerializable()
@DataRepository([JSONPlaceholderAdapter])
class Todo with DataModel<Todo> {
  @override
  final int id;
  final String title;
  final bool completed;
  final BelongsTo<User> user;

  Todo({this.id, this.title, this.completed = false, this.user});
}
