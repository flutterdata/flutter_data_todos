// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// DataGenerator
// **************************************************************************

// ignore_for_file: unused_local_variable
class _$PostRepository extends Repository<Post> {
  _$PostRepository(LocalAdapter<Post> adapter) : super(adapter);

  @override
  get relationshipMetadata => {
        'HasMany': {},
        'BelongsTo': {'user': 'users'},
        'repository#users': manager.locator<Repository<User>>()
      };
}

class $PostRepository extends _$PostRepository
    with StandardJSONAdapter<Post>, JSONPlaceholderAdapter<Post> {
  $PostRepository(LocalAdapter<Post> adapter) : super(adapter);
}

// ignore: must_be_immutable, unused_local_variable
class $PostLocalAdapter extends LocalAdapter<Post> {
  $PostLocalAdapter(DataManager manager, {box}) : super(manager, box: box);

  @override
  deserialize(map) {
    map['user'] = {
      '_': [map['user'], manager]
    };
    return Post.fromJson(map);
  }

  @override
  serialize(model) {
    final map = model.toJson();
    map['user'] = model.user?.toJson();
    return map;
  }

  @override
  setOwnerInRelationships(owner, model) {
    model.user?.owner = owner;
  }

  @override
  void setInverseInModel(inverse, model) {
    if (inverse is DataId<User>) {
      model.user?.inverse = inverse;
    }
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Post _$_$_PostFromJson(Map<String, dynamic> json) {
  return _$_Post(
    id: json['id'] as int,
    title: json['title'] as String,
    body: json['body'] as String,
    user: json['user'] == null
        ? null
        : BelongsTo.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_PostToJson(_$_Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'user': instance.user,
    };
