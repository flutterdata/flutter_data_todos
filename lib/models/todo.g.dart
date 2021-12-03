// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      id: json['id'] as int,
      description: json['title'] as String,
      completed: json['completed'] as bool? ?? false,
      user: json['user'] == null
          ? null
          : BelongsTo<User>.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.description,
      'completed': instance.completed,
      'user': instance.user,
    };

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, non_constant_identifier_names

mixin $TodoLocalAdapter on LocalAdapter<Todo> {
  @override
  Map<String, Map<String, Object?>> relationshipsFor([Todo? model]) => {
        'user': {
          'name': 'user',
          'inverse': 'todos',
          'type': 'users',
          'kind': 'BelongsTo',
          'instance': model?.user
        }
      };

  @override
  Todo deserialize(map) {
    for (final key in relationshipsFor().keys) {
      map[key] = {
        '_': [map[key], !map.containsKey(key)],
      };
    }
    return _$TodoFromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model) => _$TodoToJson(model);
}

// ignore: must_be_immutable
class $TodoHiveLocalAdapter = HiveLocalAdapter<Todo> with $TodoLocalAdapter;

class $TodoRemoteAdapter = RemoteAdapter<Todo>
    with JSONPlaceholderAdapter<Todo>;

//

final todosLocalAdapterProvider =
    Provider<LocalAdapter<Todo>>((ref) => $TodoHiveLocalAdapter(ref.read));

final todosRemoteAdapterProvider = Provider<RemoteAdapter<Todo>>(
    (ref) => $TodoRemoteAdapter(ref.watch(todosLocalAdapterProvider)));

final todosRepositoryProvider = Provider<Repository<Todo>>(
    (ref) => Repository<Todo>(ref.read, todoProvider, todosProvider));

final _todoProvider = StateNotifierProvider.autoDispose
    .family<DataStateNotifier<Todo?>, DataState<Todo?>, WatchArgs<Todo>>(
        (ref, args) {
  return ref.watch(todosRepositoryProvider).watchOneNotifier(args.id,
      remote: args.remote,
      params: args.params,
      headers: args.headers,
      alsoWatch: args.alsoWatch);
});

AutoDisposeStateNotifierProvider<DataStateNotifier<Todo?>, DataState<Todo?>>
    todoProvider(dynamic id,
        {bool? remote,
        Map<String, dynamic>? params,
        Map<String, String>? headers,
        AlsoWatch<Todo>? alsoWatch}) {
  return _todoProvider(WatchArgs(
      id: id,
      remote: remote,
      params: params,
      headers: headers,
      alsoWatch: alsoWatch));
}

final _todosProvider = StateNotifierProvider.autoDispose.family<
    DataStateNotifier<List<Todo>>,
    DataState<List<Todo>>,
    WatchArgs<Todo>>((ref, args) {
  return ref.watch(todosRepositoryProvider).watchAllNotifier(
      remote: args.remote,
      params: args.params,
      headers: args.headers,
      syncLocal: args.syncLocal);
});

AutoDisposeStateNotifierProvider<DataStateNotifier<List<Todo>>,
        DataState<List<Todo>>>
    todosProvider(
        {bool? remote,
        Map<String, dynamic>? params,
        Map<String, String>? headers,
        bool? syncLocal}) {
  return _todosProvider(WatchArgs(
      remote: remote, params: params, headers: headers, syncLocal: syncLocal));
}

extension TodoX on Todo {
  /// Initializes "fresh" models (i.e. manually instantiated) to use
  /// [save], [delete] and so on.
  ///
  /// Can be obtained via `ref.read`, `container.read`
  Todo init(Reader read, {bool save = true}) {
    final repository = internalLocatorFn(todosRepositoryProvider, read);
    final updatedModel =
        repository.remoteAdapter.initializeModel(this, save: save);
    return save ? updatedModel : this;
  }
}
