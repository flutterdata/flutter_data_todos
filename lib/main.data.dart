

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: directives_ordering, top_level_function_literal_block

import 'package:flutter_data/flutter_data.dart';

import 'package:path_provider/path_provider.dart';


import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todos/models/user.dart';
import 'package:todos/models/todo.dart';

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
      internalLocatorFn = (provider, context) => context.read(provider);
    
  return _repositoryInitializerProviderFamily(
      RepositoryInitializerArgs(remote, verbose));
};

final _repositoryInitializerProviderFamily =
  FutureProvider.family<RepositoryInitializer, RepositoryInitializerArgs>((ref, args) async {
    final graphs = <String, Map<String, RemoteAdapter>>{'todos,users': {'todos': ref.read(todoRemoteAdapterProvider), 'users': ref.read(userRemoteAdapterProvider)}};
    

      final _userRepository = ref.read(userRepositoryProvider);
      _userRepository.dispose();
      await _userRepository.initialize(
        remote: args?.remote,
        verbose: args?.verbose,
        adapters: graphs['todos,users'],
      );

      final _todoRepository = ref.read(todoRepositoryProvider);
      _todoRepository.dispose();
      await _todoRepository.initialize(
        remote: args?.remote,
        verbose: args?.verbose,
        adapters: graphs['todos,users'],
      );

    ref.onDispose(() {
      if (ref.mounted) {
              ref.read(userRepositoryProvider).dispose();
      ref.read(todoRepositoryProvider).dispose();

      }
    });

    return RepositoryInitializer();
});




