import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_data_todos/models/_adapters.dart';
import 'package:json_annotation/json_annotation.dart';

import 'todo.dart';

part 'user.g.dart';

@JsonSerializable()
@CopyWith()
@DataRepository([JSONPlaceholderAdapter])
class User extends DataModel<User> {
  @override
  final int id;
  final String name;
  late final HasMany<Todo> todos;

  User({required this.id, required this.name, HasMany<Todo>? todos})
      : todos = todos ?? HasMany();
}
