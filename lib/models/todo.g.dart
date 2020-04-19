// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// DataGenerator
// **************************************************************************

// ignore_for_file: unused_local_variable
class _$TodoRepository extends Repository<Todo> {
  _$TodoRepository(LocalAdapter<Todo> adapter) : super(adapter);

  @override
  get relationshipMetadata => {
        'HasMany': {},
        'BelongsTo': {'user': 'users'},
        'repository#users': manager.locator<Repository<User>>()
      };
}

class $TodoRepository extends _$TodoRepository
    with StandardJSONAdapter<Todo>, JSONPlaceholderAdapter<Todo> {
  $TodoRepository(LocalAdapter<Todo> adapter) : super(adapter);
}

// ignore: must_be_immutable, unused_local_variable
class $TodoLocalAdapter extends LocalAdapter<Todo> {
  $TodoLocalAdapter(DataManager manager, {box}) : super(manager, box: box);

  @override
  deserialize(map) {
    map['user'] = {
      '_': [map['user'], manager]
    };
    return Todo.fromJson(map);
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

_$_Todo _$_$_TodoFromJson(Map<String, dynamic> json) {
  return _$_Todo(
    id: json['id'] as int,
    title: json['title'] as String,
    completed: json['completed'] as bool ?? false,
    user: json['user'] == null
        ? null
        : BelongsTo.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_TodoToJson(_$_Todo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'completed': instance.completed,
      'user': instance.user,
    };
