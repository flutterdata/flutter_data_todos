import 'package:flutter_data/annotations.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/models/user.dart';

import 'adapters.dart';

part 'post.g.dart';
part 'post.freezed.dart';

@freezed
@DataRepository([StandardJSONAdapter, JSONPlaceholderAdapter])
abstract class Post extends IdDataSupport<int, Post> implements _$Post {
  Post._();
  factory Post({
    int id,
    String title,
    String body,
    BelongsTo<User> user,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
