// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserCWProxy {
  User id(int id);

  User name(String name);

  User todos(HasMany<Todo>? todos);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `User(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// User(...).copyWith(id: 12, name: "My name")
  /// ````
  User call({
    int? id,
    String? name,
    HasMany<Todo>? todos,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUser.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUser.copyWith.fieldName(...)`
class _$UserCWProxyImpl implements _$UserCWProxy {
  final User _value;

  const _$UserCWProxyImpl(this._value);

  @override
  User id(int id) => this(id: id);

  @override
  User name(String name) => this(name: name);

  @override
  User todos(HasMany<Todo>? todos) => this(todos: todos);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `User(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// User(...).copyWith(id: 12, name: "My name")
  /// ````
  User call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? todos = const $CopyWithPlaceholder(),
  }) {
    return User(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      todos: todos == const $CopyWithPlaceholder()
          ? _value.todos
          // ignore: cast_nullable_to_non_nullable
          : todos as HasMany<Todo>?,
    );
  }
}

extension $UserCopyWith on User {
  /// Returns a callable class that can be used as follows: `instanceOfUser.copyWith(...)` or like so:`instanceOfUser.copyWith.fieldName(...)`.
  _$UserCWProxy get copyWith => _$UserCWProxyImpl(this);
}

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, duplicate_ignore

mixin $UserLocalAdapter on LocalAdapter<User> {
  static final Map<String, RelationshipMeta> _kUserRelationshipMetas = {
    'todos': RelationshipMeta<Todo>(
      name: 'todos',
      inverseName: 'user',
      type: 'todos',
      kind: 'HasMany',
      instance: (_) => (_ as User).todos,
    )
  };

  @override
  Map<String, RelationshipMeta> get relationshipMetas =>
      _kUserRelationshipMetas;

  @override
  User deserialize(map) {
    map = transformDeserialize(map);
    return _$UserFromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model, {bool withRelationships = true}) {
    final map = _$UserToJson(model);
    return transformSerialize(map, withRelationships: withRelationships);
  }
}

final _usersFinders = <String, dynamic>{};

// ignore: must_be_immutable
class $UserHiveLocalAdapter = HiveLocalAdapter<User> with $UserLocalAdapter;

class $UserRemoteAdapter = RemoteAdapter<User>
    with JSONPlaceholderAdapter<User>;

final internalUsersRemoteAdapterProvider = Provider<RemoteAdapter<User>>(
    (ref) => $UserRemoteAdapter(
        $UserHiveLocalAdapter(ref.read), InternalHolder(_usersFinders)));

final usersRepositoryProvider =
    Provider<Repository<User>>((ref) => Repository<User>(ref.read));

extension UserDataRepositoryX on Repository<User> {
  JSONPlaceholderAdapter<User> get jSONPlaceholderAdapter =>
      remoteAdapter as JSONPlaceholderAdapter<User>;
}

extension UserRelationshipGraphNodeX on RelationshipGraphNode<User> {
  RelationshipGraphNode<Todo> get todos {
    final meta = $UserLocalAdapter._kUserRelationshipMetas['todos']
        as RelationshipMeta<Todo>;
    return meta.clone(
        parent: this is RelationshipMeta ? this as RelationshipMeta : null);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      name: json['name'] as String,
      todos: json['todos'] == null
          ? null
          : HasMany<Todo>.fromJson(json['todos'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'todos': instance.todos,
    };
