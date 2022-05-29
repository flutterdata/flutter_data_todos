// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TodoCWProxy {
  Todo completed(bool completed);

  Todo description(String description);

  Todo id(int id);

  Todo user(BelongsTo<User>? user);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Todo(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Todo(...).copyWith(id: 12, name: "My name")
  /// ````
  Todo call({
    bool? completed,
    String? description,
    int? id,
    BelongsTo<User>? user,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTodo.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTodo.copyWith.fieldName(...)`
class _$TodoCWProxyImpl implements _$TodoCWProxy {
  final Todo _value;

  const _$TodoCWProxyImpl(this._value);

  @override
  Todo completed(bool completed) => this(completed: completed);

  @override
  Todo description(String description) => this(description: description);

  @override
  Todo id(int id) => this(id: id);

  @override
  Todo user(BelongsTo<User>? user) => this(user: user);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Todo(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Todo(...).copyWith(id: 12, name: "My name")
  /// ````
  Todo call({
    Object? completed = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
  }) {
    return Todo(
      completed: completed == const $CopyWithPlaceholder() || completed == null
          ? _value.completed
          // ignore: cast_nullable_to_non_nullable
          : completed as bool,
      description:
          description == const $CopyWithPlaceholder() || description == null
              ? _value.description
              // ignore: cast_nullable_to_non_nullable
              : description as String,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as BelongsTo<User>?,
    );
  }
}

extension $TodoCopyWith on Todo {
  /// Returns a callable class that can be used as follows: `instanceOfTodo.copyWith(...)` or like so:`instanceOfTodo.copyWith.fieldName(...)`.
  _$TodoCWProxy get copyWith => _$TodoCWProxyImpl(this);
}

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, duplicate_ignore

mixin $TodoLocalAdapter on LocalAdapter<Todo> {
  static final Map<String, RelationshipMeta> _kTodoRelationshipMetas = {
    'userId': RelationshipMeta<User>(
      name: 'user',
      inverseName: 'todos',
      type: 'users',
      kind: 'BelongsTo',
      instance: (_) => (_ as Todo).user,
    )
  };

  @override
  Map<String, RelationshipMeta> get relationshipMetas =>
      _kTodoRelationshipMetas;

  @override
  Todo deserialize(map) {
    map = transformDeserialize(map);
    return _$TodoFromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model, {bool withRelationships = true}) {
    final map = _$TodoToJson(model);
    return transformSerialize(map, withRelationships: withRelationships);
  }
}

final _todosFinders = <String, dynamic>{};

// ignore: must_be_immutable
class $TodoHiveLocalAdapter = HiveLocalAdapter<Todo> with $TodoLocalAdapter;

class $TodoRemoteAdapter = RemoteAdapter<Todo>
    with JSONPlaceholderAdapter<Todo>;

final internalTodosRemoteAdapterProvider = Provider<RemoteAdapter<Todo>>(
    (ref) => $TodoRemoteAdapter(
        $TodoHiveLocalAdapter(ref.read), InternalHolder(_todosFinders)));

final todosRepositoryProvider =
    Provider<Repository<Todo>>((ref) => Repository<Todo>(ref.read));

extension TodoDataRepositoryX on Repository<Todo> {
  JSONPlaceholderAdapter<Todo> get jSONPlaceholderAdapter =>
      remoteAdapter as JSONPlaceholderAdapter<Todo>;
}

extension TodoRelationshipGraphNodeX on RelationshipGraphNode<Todo> {
  RelationshipGraphNode<User> get user {
    final meta = $TodoLocalAdapter._kTodoRelationshipMetas['userId']
        as RelationshipMeta<User>;
    return meta.clone(
        parent: this is RelationshipMeta ? this as RelationshipMeta : null);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      id: json['id'] as int,
      description: json['title'] as String,
      completed: json['completed'] as bool? ?? false,
      user: json['userId'] == null
          ? null
          : BelongsTo<User>.fromJson(json['userId'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.description,
      'completed': instance.completed,
      'userId': instance.user,
    };
