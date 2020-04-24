// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// DataGenerator
// **************************************************************************

// ignore_for_file: unused_local_variable
// ignore_for_file: always_declare_return_types
class _$TodoRepository extends Repository<Todo> {
  _$TodoRepository(LocalAdapter<Todo> adapter) : super(adapter);

  @override
  get relationshipMetadata => {'HasMany': {}, 'BelongsTo': {}};
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
    return _$TodoFromJson(map);
  }

  @override
  serialize(model) {
    final map = _$TodoToJson(model);

    return map;
  }

  @override
  setOwnerInRelationships(owner, model) {}

  @override
  void setInverseInModel(inverse, model) {}
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) {
  return Todo(
    id: json['id'] as int,
    title: json['title'] as String,
    completed: json['completed'] as bool,
  );
}

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'completed': instance.completed,
    };
