

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: directives_ordering, top_level_function_literal_block

import 'package:flutter_data/flutter_data.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todos/models/todo.dart';
import 'package:todos/models/user.dart';

// ignore: prefer_function_declarations_over_variables
ConfigureRepositoryLocalStorage configureRepositoryLocalStorage = ({FutureFn<String>? baseDirFn, List<int>? encryptionKey, bool? clear}) {
  if (!kIsWeb) {
    baseDirFn ??= () => getApplicationDocumentsDirectory().then((dir) => dir.path);
  } else {
    baseDirFn ??= () => '';
  }
  
  return hiveLocalStorageProvider.overrideWithProvider(Provider(
        (_) => HiveLocalStorage(baseDirFn: baseDirFn, encryptionKey: encryptionKey, clear: clear)));
};

// ignore: prefer_function_declarations_over_variables
RepositoryInitializerProvider repositoryInitializerProvider = (
        {bool? remote, bool? verbose}) {
  return _repositoryInitializerProviderFamily(
      RepositoryInitializerArgs(remote, verbose));
};

final repositoryProviders = <String, Provider<Repository<DataModel>>>{
  'todos': todosRepositoryProvider,
'users': usersRepositoryProvider
};

final _repositoryInitializerProviderFamily =
  FutureProvider.family<RepositoryInitializer, RepositoryInitializerArgs>((ref, args) async {
    final adapters = <String, RemoteAdapter>{'todos': ref.watch(todosRemoteAdapterProvider), 'users': ref.watch(usersRemoteAdapterProvider)};
    final remotes = <String, bool>{'todos': true, 'users': true};

    await ref.watch(graphNotifierProvider).initialize();

    for (final key in repositoryProviders.keys) {
      final repository = ref.watch(repositoryProviders[key]!);
      repository.dispose();
      await repository.initialize(
        remote: args.remote ?? remotes[key],
        verbose: args.verbose,
        adapters: adapters,
      );
    }

    ref.onDispose(() {
      for (final repositoryProvider in repositoryProviders.values) {
        ref.watch(repositoryProvider).dispose();
      }
    });

    return RepositoryInitializer();
});
extension RepositoryWidgetRefX on WidgetRef {
  Repository<Todo> get todos => watch(todosRepositoryProvider)..internalWatch = watch;
  Repository<User> get users => watch(usersRepositoryProvider)..internalWatch = watch;
}

extension RepositoryRefX on Ref {
  Repository<Todo> get todos => watch(todosRepositoryProvider)..internalWatch = watch as Watcher;
  Repository<User> get users => watch(usersRepositoryProvider)..internalWatch = watch as Watcher;
}