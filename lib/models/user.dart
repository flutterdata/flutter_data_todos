import 'package:flutter_data/flutter_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todos/models/_adapters.dart';

import 'todo.dart';

part 'user.g.dart';

@JsonSerializable()
@DataRepository([JSONPlaceholderAdapter])
class User with DataModel<User> {
  @override
  final int id;
  final String name;
  final HasMany<Todo> todos;

  User({this.id, this.name, this.todos});
}
