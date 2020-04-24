// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// DataGenerator
// **************************************************************************

// ignore_for_file: unused_local_variable
// ignore_for_file: always_declare_return_types
class _$UserRepository extends Repository<User> {
  _$UserRepository(LocalAdapter<User> adapter) : super(adapter);

  @override
  get relationshipMetadata => {
        'HasMany': {'todos': 'todos'},
        'BelongsTo': {},
        'repository#todos': manager.locator<Repository<Todo>>()
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
    return _$UserFromJson(map);
  }

  @override
  serialize(model) {
    final map = _$UserToJson(model);
    map['todos'] = model.todos?.toJson();
    return map;
  }

  @override
  setOwnerInRelationships(owner, model) {
    model.todos?.owner = owner;
  }

  @override
  void setInverseInModel(inverse, model) {
    if (inverse is DataId<Todo>) {
      model.todos?.inverse = inverse;
    }
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    name: json['name'] as String,
    todos: json['todos'] == null
        ? null
        : HasMany.fromJson(json['todos'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'todos': instance.todos,
    };
