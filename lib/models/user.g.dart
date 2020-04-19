// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// DataGenerator
// **************************************************************************

// ignore_for_file: unused_local_variable
class _$UserRepository extends Repository<User> {
  _$UserRepository(LocalAdapter<User> adapter) : super(adapter);

  @override
  get relationshipMetadata => {
        'HasMany': {'todos': 'todos', 'posts': 'posts'},
        'BelongsTo': {},
        'repository#todos': manager.locator<Repository<Todo>>(),
        'repository#posts': manager.locator<Repository<Post>>()
      };
}

class $UserRepository extends _$UserRepository
    with StandardJSONAdapter<User>, JSONPlaceholderAdapter<User> {
  $UserRepository(LocalAdapter<User> adapter) : super(adapter);
}

// ignore: must_be_immutable, unused_local_variable
class $UserLocalAdapter extends LocalAdapter<User> {
  $UserLocalAdapter(DataManager manager, {box}) : super(manager, box: box);

  @override
  deserialize(map) {
    map['todos'] = {
      '_': [map['todos'], manager]
    };
    map['posts'] = {
      '_': [map['posts'], manager]
    };
    return User.fromJson(map);
  }

  @override
  serialize(model) {
    final map = model.toJson();
    map['todos'] = model.todos?.toJson();
    map['posts'] = model.posts?.toJson();
    return map;
  }

  @override
  setOwnerInRelationships(owner, model) {
    model.todos?.owner = owner;
    model.posts?.owner = owner;
  }

  @override
  void setInverseInModel(inverse, model) {
    if (inverse is DataId<Todo>) {
      model.todos?.inverse = inverse;
    }
    if (inverse is DataId<Post>) {
      model.posts?.inverse = inverse;
    }
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$_$_UserFromJson(Map<String, dynamic> json) {
  return _$_User(
    id: json['id'] as int,
    name: json['name'] as String,
    email: json['email'] as String,
    todos: json['todos'] == null
        ? null
        : HasMany.fromJson(json['todos'] as Map<String, dynamic>),
    posts: json['posts'] == null
        ? null
        : HasMany.fromJson(json['posts'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_UserToJson(_$_User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'todos': instance.todos,
      'posts': instance.posts,
    };
