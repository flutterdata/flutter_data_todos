// ignore_for_file: body_might_complete_normally_nullable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_data_todos/models/todo.dart';
import 'package:flutter_data_todos/models/user.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_data/flutter_data.dart';

import 'main.data.dart';

void main() {
  runApp(
    ProviderScope(
      child: const MyApp(),
      overrides: [
        configureRepositoryLocalStorage(clear: false),
      ],
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(repositoryInitializerProvider);
        },
        child: ref.watch(repositoryInitializerProvider).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text(err.toString())),
              data: (_) => const Home(),
            ),
      ),
    );
  }
}

class Home extends HookConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userProvider);
    final newTodoController = useTextEditingController();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Builder(
          builder: (context) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            final filteredTodos = ref.watch(filteredTodosProvider);
            final user = state.model!;

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              children: [
                const Title(),
                TextField(
                  key: addTodoKey,
                  controller: newTodoController,
                  decoration: InputDecoration(
                    labelText: 'What needs to be done, ${user.name}?',
                  ),
                  onSubmitted: (value) async {
                    if (value.isNotEmpty) {
                      Todo(
                        id: Random().nextInt(999) + 2,
                        completed: true,
                        description: value,
                        user: state.model!.asBelongsTo,
                      ).save(
                          remote: true,
                          onError: (e, label, adapter) async {
                            await adapter.onError(e, label); // optional
                            adapter.log(
                                label, 'custom logging: ${label.model}');
                            ref
                                .read(userProvider.notifier)
                                .updateWith(exception: e);
                          });
                      newTodoController.clear();
                    }
                  },
                ),
                if (state.hasException)
                  GestureDetector(
                    onTap: () => ref
                        .read(userProvider.notifier)
                        .updateWith(exception: null),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        '''Something went wrong: ${state.exception}
(MyJSONServer does not support saving!)

Tap to dismiss.''',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.red),
                      ),
                    ),
                  ),
                const SizedBox(height: 42),
                const Toolbar(),
                if (filteredTodos.isNotEmpty) const Divider(height: 0),
                for (final todo in filteredTodos) ...[
                  const Divider(height: 0),
                  Dismissible(
                    key: ValueKey(todo.id),
                    onDismissed: (_) {
                      todo.delete();
                    },
                    child: ProviderScope(
                      overrides: [
                        _currentTodo.overrideWithValue(todo),
                      ],
                      child: const TodoItem(),
                    ),
                  )
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class Toolbar extends HookConsumerWidget {
  const Toolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.read(todoListFilter);

    Color? textColorFor(TodoListFilter value) {
      return filter == value ? Colors.blue : Colors.black;
    }

    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '${ref.watch(uncompletedTodosCount).toString()} items left',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Tooltip(
            key: allFilterKey,
            message: 'All todos',
            child: TextButton(
              onPressed: () =>
                  ref.read(todoListFilter.notifier).state = TodoListFilter.all,
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor: MaterialStateProperty.all(
                  textColorFor(TodoListFilter.all),
                ),
              ),
              child: const Text('All'),
            ),
          ),
          Tooltip(
            key: activeFilterKey,
            message: 'Only uncompleted todos',
            child: TextButton(
              onPressed: () => ref.read(todoListFilter.notifier).state =
                  TodoListFilter.active,
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor: MaterialStateProperty.all(
                    textColorFor(TodoListFilter.active)),
              ),
              child: const Text('Active'),
            ),
          ),
          Tooltip(
            key: completedFilterKey,
            message: 'Only completed todos',
            child: TextButton(
              onPressed: () => ref.read(todoListFilter.notifier).state =
                  TodoListFilter.completed,
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor: MaterialStateProperty.all(
                  textColorFor(TodoListFilter.completed),
                ),
              ),
              child: const Text('Completed'),
            ),
          ),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'todos',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color.fromARGB(38, 47, 47, 247),
        fontSize: 100,
        fontWeight: FontWeight.w100,
        fontFamily: 'Helvetica Neue',
      ),
    );
  }
}

/// A provider which exposes the [Todo] displayed by a [TodoItem].
///
/// By retreiving the [Todo] through a provider instead of through its
/// constructor, this allows [TodoItem] to be instantiated using the `const` keyword.
///
/// This ensures that when we add/remove/edit todos, only what the
/// impacted widgets rebuilds, instead of the entire list of items.
final _currentTodo = Provider<Todo>((ref) => throw UnimplementedError());

class TodoItem extends HookConsumerWidget {
  const TodoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(_currentTodo);
    final itemFocusNode = useFocusNode();
    // listen to focus chances
    useListenable(itemFocusNode);
    final isFocused = itemFocusNode.hasFocus;

    final textEditingController = useTextEditingController();
    final textFieldFocusNode = useFocusNode();

    return Material(
      color: Colors.white,
      elevation: 6,
      child: Focus(
        focusNode: itemFocusNode,
        onFocusChange: (focused) {
          if (focused) {
            textEditingController.text = todo.description;
          } else if (todo.description != textEditingController.text) {
            todo.copyWith(description: textEditingController.text).save(
              onError: (e, _, __) {
                ref.read(userProvider.notifier).updateWith(exception: e);
              },
            );
          }
        },
        child: ListTile(
            onTap: () {
              itemFocusNode.requestFocus();
              textFieldFocusNode.requestFocus();
            },
            leading: Checkbox(
              value: todo.completed,
              onChanged: (value) {
                todo.copyWith(completed: !todo.completed).save(
                      remote: true,
                      onError: (e, _, __) {
                        ref
                            .read(userProvider.notifier)
                            .updateWith(exception: e);
                      },
                    );
              },
            ),
            title: isFocused
                ? TextField(
                    autofocus: true,
                    focusNode: textFieldFocusNode,
                    controller: textEditingController,
                  )
                : Text(todo.description)),
      ),
    );
  }
}

// Providers

// NOTE: this is purely for `alsoWatch` demonstration purposes
// as we'd otherwise simply use `ref.todos.watchAll()`
final userProvider = StateNotifierProvider.autoDispose<DataStateNotifier<User?>,
    DataState<User?>>((ref) {
  ref.users.logLevel = 2;
  ref.todos.logLevel = 2;
  return ref.users.watchOneNotifier(1,
      params: {'_embed': 'todos'}, alsoWatch: (u) => {u.todos});
});

/// The different ways to filter the list of todos
enum TodoListFilter {
  all,
  active,
  completed,
}

/// The currently active filter.
///
/// We use [StateProvider] here as there is no fancy logic behind manipulating
/// the value since it's just enum.
final todoListFilter = StateProvider((_) => TodoListFilter.all);

/// The number of uncompleted todos
///
/// By using [Provider], this value is cached, making it performant.\
/// Even multiple widgets try to read the number of uncompleted todos,
/// the value will be computed only once (until the todo-list changes).
///
/// This will also optimise unneeded rebuilds if the todo-list changes, but the
/// number of uncompleted todos doesn't (such as when editing a todo).
final uncompletedTodosCount = Provider.autoDispose<int>((ref) {
  final state = ref.watch(userProvider);
  if (!state.hasModel) {
    return 0;
  }
  return state.model!.todos.where((todo) => !todo.completed).length;
});

/// The list of todos after applying of [todoListFilter].
///
/// This too uses [Provider], to avoid recomputing the filtered list unless either
/// the filter of or the todo-list updates.
final filteredTodosProvider = Provider.autoDispose<List<Todo>>((ref) {
  final filter = ref.watch(todoListFilter);
  final state = ref.watch(userProvider);
  final todos = state.model!.todos.toList()
    ..sort(((a, b) => a.id.compareTo(b.id)));

  switch (filter) {
    case TodoListFilter.completed:
      return todos.where((todo) => todo.completed).toList();
    case TodoListFilter.active:
      return todos.where((todo) => !todo.completed).toList();
    case TodoListFilter.all:
      return todos;
  }
});

/// Some keys used for testing
final addTodoKey = UniqueKey();
final activeFilterKey = UniqueKey();
final completedFilterKey = UniqueKey();
final allFilterKey = UniqueKey();
