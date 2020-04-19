// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'todo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Todo _$TodoFromJson(Map<String, dynamic> json) {
  return _Todo.fromJson(json);
}

class _$TodoTearOff {
  const _$TodoTearOff();

  _Todo call(
      {int id, String title, bool completed = false, BelongsTo<User> user}) {
    return _Todo(
      id: id,
      title: title,
      completed: completed,
      user: user,
    );
  }
}

// ignore: unused_element
const $Todo = _$TodoTearOff();

mixin _$Todo {
  int get id;
  String get title;
  bool get completed;
  BelongsTo<User> get user;

  Map<String, dynamic> toJson();
  $TodoCopyWith<Todo> get copyWith;
}

abstract class $TodoCopyWith<$Res> {
  factory $TodoCopyWith(Todo value, $Res Function(Todo) then) =
      _$TodoCopyWithImpl<$Res>;
  $Res call({int id, String title, bool completed, BelongsTo<User> user});
}

class _$TodoCopyWithImpl<$Res> implements $TodoCopyWith<$Res> {
  _$TodoCopyWithImpl(this._value, this._then);

  final Todo _value;
  // ignore: unused_field
  final $Res Function(Todo) _then;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object completed = freezed,
    Object user = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      title: title == freezed ? _value.title : title as String,
      completed: completed == freezed ? _value.completed : completed as bool,
      user: user == freezed ? _value.user : user as BelongsTo<User>,
    ));
  }
}

abstract class _$TodoCopyWith<$Res> implements $TodoCopyWith<$Res> {
  factory _$TodoCopyWith(_Todo value, $Res Function(_Todo) then) =
      __$TodoCopyWithImpl<$Res>;
  @override
  $Res call({int id, String title, bool completed, BelongsTo<User> user});
}

class __$TodoCopyWithImpl<$Res> extends _$TodoCopyWithImpl<$Res>
    implements _$TodoCopyWith<$Res> {
  __$TodoCopyWithImpl(_Todo _value, $Res Function(_Todo) _then)
      : super(_value, (v) => _then(v as _Todo));

  @override
  _Todo get _value => super._value as _Todo;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object completed = freezed,
    Object user = freezed,
  }) {
    return _then(_Todo(
      id: id == freezed ? _value.id : id as int,
      title: title == freezed ? _value.title : title as String,
      completed: completed == freezed ? _value.completed : completed as bool,
      user: user == freezed ? _value.user : user as BelongsTo<User>,
    ));
  }
}

@JsonSerializable()
class _$_Todo extends _Todo {
  _$_Todo({this.id, this.title, this.completed = false, this.user})
      : assert(completed != null),
        super._();

  factory _$_Todo.fromJson(Map<String, dynamic> json) =>
      _$_$_TodoFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @JsonKey(defaultValue: false)
  @override
  final bool completed;
  @override
  final BelongsTo<User> user;

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, completed: $completed, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Todo &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.completed, completed) ||
                const DeepCollectionEquality()
                    .equals(other.completed, completed)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(completed) ^
      const DeepCollectionEquality().hash(user);

  @override
  _$TodoCopyWith<_Todo> get copyWith =>
      __$TodoCopyWithImpl<_Todo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_TodoToJson(this);
  }
}

abstract class _Todo extends Todo {
  _Todo._() : super._();
  factory _Todo({int id, String title, bool completed, BelongsTo<User> user}) =
      _$_Todo;

  factory _Todo.fromJson(Map<String, dynamic> json) = _$_Todo.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  bool get completed;
  @override
  BelongsTo<User> get user;
  @override
  _$TodoCopyWith<_Todo> get copyWith;
}
