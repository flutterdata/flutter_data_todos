import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todos/models/todo.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:todos/models/user.dart';

import 'main.data.dart';

void main() {
  runApp(ProviderScope(
    child: MyApp(),
    overrides: [
      configureRepositoryLocalStorage(clear: true),
    ],
  ));
}

class MyApp extends HookWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RefreshIndicator(
        onRefresh: () async {
          await context.refresh(repositoryInitializerProvider());
        },
        child: useProvider(repositoryInitializerProvider()).when(
          loading: () => Center(child: const CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text(err.toString())),
          data: (_) => Home(),
        ),
      ),
    );
  }
}

class Home extends HookWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useProvider(userProvider.state);
    final newTodoController = useTextEditingController();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: HookBuilder(
          builder: (context) {
            if (state.isLoading) {
              return Center(child: const CircularProgressIndicator());
            }
            final filteredTodos = useProvider(filteredTodosProvider);
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              children: [
                if (state.hasException)
                  Text('there was an exception! ${state.exception}'),
                const Title(),
                TextField(
                  key: addTodoKey,
                  controller: newTodoController,
                  decoration: const InputDecoration(
                    labelText: 'What needs to be done?',
                  ),
                  onSubmitted: (value) async {
                    if (value != '') {
                      final repo = context.read(todoRepositoryProvider);
                      Todo(
                        id: Random().nextInt(999) + 2,
                        completed: true,
                        description: value,
                        // TODO fix
                        user: filteredTodos.first?.user?.value?.asBelongsTo,
                      ).init(repo).save();
                    }

                    newTodoController.clear();
                  },
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

class Toolbar extends HookWidget {
  const Toolbar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = useProvider(todoListFilter);

    Color textColorFor(TodoListFilter value) {
      return filter.state == value ? Colors.blue : null;
    }

    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '${useProvider(uncompletedTodosCount).toString()} items left',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Tooltip(
            key: allFilterKey,
            message: 'All todos',
            // ignore: deprecated_member_use, TextButton is not available in stable yet
            child: FlatButton(
              onPressed: () => filter.state = TodoListFilter.all,
              visualDensity: VisualDensity.compact,
              textColor: textColorFor(TodoListFilter.all),
              child: const Text('All'),
            ),
          ),
          Tooltip(
            key: activeFilterKey,
            message: 'Only uncompleted todos',
            // ignore: deprecated_member_use, TextButton is not available in stable yet
            child: FlatButton(
              onPressed: () => filter.state = TodoListFilter.active,
              visualDensity: VisualDensity.compact,
              textColor: textColorFor(TodoListFilter.active),
              child: const Text('Active'),
            ),
          ),
          Tooltip(
            key: completedFilterKey,
            message: 'Only completed todos',
            // ignore: deprecated_member_use, TextButton is not available in stable yet
            child: FlatButton(
              onPressed: () => filter.state = TodoListFilter.completed,
              visualDensity: VisualDensity.compact,
              textColor: textColorFor(TodoListFilter.completed),
              child: const Text('Completed'),
            ),
          ),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({Key key}) : super(key: key);

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
final _currentTodo = ScopedProvider<Todo>(null);

class TodoItem extends HookWidget {
  const TodoItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo = useProvider(_currentTodo);
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
            final todoRepository = context.read(todoRepositoryProvider);
            todoRepository.save(Todo(
              id: todo.id,
              completed: todo.completed,
              description: textEditingController.text,
            ));
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
              final todoRepository = context.read(todoRepositoryProvider);
              todoRepository.save(Todo(
                  id: todo.id,
                  completed: !todo.completed,
                  description: todo.description));
            },
          ),
          title: isFocused
              ? TextField(
                  autofocus: true,
                  focusNode: textFieldFocusNode,
                  controller: textEditingController,
                )
              : Text(todo.description),
        ),
      ),
    );
  }
}

// Providers

final userProvider = watchUser(
  1,
  params: {'_embed': 'todos'},
  alsoWatch: (User user) => [user.todos],
);

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
  final state = ref.watch(userProvider.state);
  if (!state.hasModel) {
    return 0;
  }
  return state.model.todos.where((todo) => !todo.completed).length;
});

/// The list of todos after applying of [todoListFilter].
///
/// This too uses [Provider], to avoid recomputing the filtered list unless either
/// the filter of or the todo-list updates.
final filteredTodosProvider = Provider.autoDispose<List<Todo>>((ref) {
  final state = ref.watch(userProvider.state);
  // if (!state.hasModel) {
  //   return [];
  // }

  final filter = ref.watch(todoListFilter);
  final todos = state.model.todos.toList();

  switch (filter.state) {
    case TodoListFilter.completed:
      return todos.where((todo) => todo.completed).toList();
    case TodoListFilter.active:
      return todos.where((todo) => !todo.completed).toList();
    case TodoListFilter.all:
    default:
      return todos;
  }
});

/// Some keys used for testing
final addTodoKey = UniqueKey();
final activeFilterKey = UniqueKey();
final completedFilterKey = UniqueKey();
final allFilterKey = UniqueKey();
