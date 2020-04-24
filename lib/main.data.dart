

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: directives_ordering

import 'dart:io';
import 'package:flutter_data/flutter_data.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:todos/models/user.dart';
import 'package:todos/models/todo.dart';

extension FlutterData on DataManager {

  static Future<DataManager> init(Directory baseDir, {bool autoModelInit = true, bool clear = true, Function(void Function<R>(R)) also}) async {
    assert(baseDir != null);

    final injection = DataServiceLocator();

    final manager = await DataManager(autoModelInit: autoModelInit).init(baseDir, injection.locator, clear: clear);
    injection.register(manager);
    final userLocalAdapter = await $UserLocalAdapter(manager).init();
    injection.register(userLocalAdapter);
    injection.register<Repository<User>>($UserRepository(userLocalAdapter));

    final todoLocalAdapter = await $TodoLocalAdapter(manager).init();
    injection.register(todoLocalAdapter);
    injection.register<Repository<Todo>>($TodoRepository(todoLocalAdapter));


    if (also != null) {
      // ignore: unnecessary_lambdas
      also(<R>(R obj) => injection.register<R>(obj));
    }

    return manager;

}

  List<SingleChildWidget> get providers {
  return [
    Provider<Repository<User>>.value(value: locator<Repository<User>>()),
Provider<Repository<Todo>>.value(value: locator<Repository<Todo>>()),
  ];
}

  
}



List<SingleChildWidget> dataProviders(Future<Directory> Function() directory, {bool clear = true}) => [
  FutureProvider<DataManager>(
    create: (_) => directory().then((dir) {
          return FlutterData.init(dir, clear: clear);
        })),


    ProxyProvider<DataManager, Repository<User>>(
      lazy: false,
      update: (_, m, __) => m?.locator<Repository<User>>(),
    ),


    ProxyProvider<DataManager, Repository<Todo>>(
      lazy: false,
      update: (_, m, __) => m?.locator<Repository<Todo>>(),
    ),];
