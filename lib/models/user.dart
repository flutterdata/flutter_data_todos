import 'package:flutter_data/annotations.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/models/post.dart';
import 'package:todo_app/models/todo.dart';

import 'adapters.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@freezed
@DataRepository([StandardJSONAdapter, JSONPlaceholderAdapter])
abstract class User extends IdDataSupport<int, User> implements _$User {
  User._();
  factory User({
    int id,
    String name,
    String email,
    HasMany<Todo> todos,
    HasMany<Post> posts,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
