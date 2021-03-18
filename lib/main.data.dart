

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: directives_ordering, top_level_function_literal_block

import 'package:flutter_data/flutter_data.dart';

import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todos/models/todo.dart';
import 'package:todos/models/user.dart';

// ignore: prefer_function_declarations_over_variables
ConfigureRepositoryLocalStorage configureRepositoryLocalStorage = ({FutureFn<String> baseDirFn, List<int> encryptionKey, bool clear}) {
  // ignore: unnecessary_statements
  baseDirFn ??= () => getApplicationDocumentsDirectory().then((dir) => dir.path);
  return hiveLocalStorageProvider.overrideWithProvider(Provider(
        (_) => HiveLocalStorage(baseDirFn: baseDirFn, encryptionKey: encryptionKey, clear: clear)));
};

// ignore: prefer_function_declarations_over_variables
RepositoryInitializerProvider repositoryInitializerProvider = (
        {bool remote, bool verbose}) {
  return _repositoryInitializerProviderFamily(
      RepositoryInitializerArgs(remote, verbose));
};

final repositoryProviders = {
  todoRepositoryProvider,
userRepositoryProvider
};

final _repositoryInitializerProviderFamily =
  FutureProvider.family<RepositoryInitializer, RepositoryInitializerArgs>((ref, args) async {
    final adapters = <String, RemoteAdapter>{'todos': ref.read(todoRemoteAdapterProvider), 'users': ref.read(userRemoteAdapterProvider)};

    for (final repositoryProvider in repositoryProviders) {
      final repository = ref.read(repositoryProvider);
      repository.dispose();
      await repository.initialize(
        remote: args?.remote,
        verbose: args?.verbose,
        adapters: adapters,
      );
    }

    ref.onDispose(() {
      if (ref.mounted) {
        for (final repositoryProvider in repositoryProviders) {
          ref.read(repositoryProvider).dispose();
        }
      }
    });

    return RepositoryInitializer();
});
