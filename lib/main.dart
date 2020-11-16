import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todos/main.data.dart';

import 'models/todo.dart';
import 'models/user.dart';

main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return ProviderScope(
      overrides: [
        configureRepositoryLocalStorage(clear: false),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          home: Scaffold(
            body: HookBuilder(
              builder: (context) {
                return useProvider(repositoryInitializerProvider()).when(
                  data: (_) => TodoScreen(),
                  loading: () => const CircularProgressIndicator(),
                  error: (err, stack) =>
                      Center(child: Text('err: $err / $stack')),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                // final user = await context
                //     .read<Repository<User>>()
                //     .findOne('1', remote: false);

                final repo = context.read(userRepositoryProvider);
                final user = await repo.findOne('1', remote: false);

                final todo = Todo(
                    id: Random().nextInt(99) + 2,
                    title: "Task number ${Random().nextInt(9999)}",
                    user: BelongsTo());

                // await todo.save();
                user.todos.add(todo);
                await user.save();
              },
              child: Icon(Icons.add),
            ),
          ),
          theme: theme,
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}

class TodoScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final state = useProvider(
      watchUser(
        1,
        params: {'_embed': 'todos'},
        // alsoWatch: (user) => [user.todos],
      ),
    );

    return RefreshIndicator(
      onRefresh: () async {
        return context.refresh(
          watchUser(
            1,
            params: {'_embed': 'todos'},
            alsoWatch: (user) => [user.todos],
          ),
        );
      },
      child: TodoList(state),
    );
  }
}

class TodoList extends HookWidget {
  final DataState<User> state;
  final List<Todo> todos;
  TodoList(this.state, {Key key})
      : todos = state.model?.todos?.toList(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state.hasException) {
      return Text(state.exception.toString());
    }
    if (state.isLoading) {
      return Center(child: const CircularProgressIndicator());
    }
    return ListView.separated(
      itemBuilder: (context, i) {
        final todo = todos[i];
        return GestureDetector(
          onDoubleTap: () async {
            final repository = context.read(userRepositoryProvider);
            final todoRepository = context.read(todoRepositoryProvider);
            final user = await repository.findOne('1', remote: false);
            if (todo.id != null) {
              Todo(
                id: todo.id,
                title: todo.title,
                completed: !todo.completed,
                user: user.asBelongsTo,
              ).init(todoRepository).save();
            }
          },
          child: Dismissible(
            child: Text('''${todo.completed ? "✅" : "◻️"} (${todos.length})
              [id: ${todo.id} / ${keyFor(todo)}] ${todo.title}
              / u: ${todo.user?.value?.id} / ${todo.hashCode}'''),
            key: ValueKey(todo),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) async {
              await todo.delete();
            },
          ),
        );
      },
      itemCount: todos.length,
      separatorBuilder: (context, i) => Divider(),
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
    );
  }
}

final theme = ThemeData.dark().copyWith(
  textTheme: GoogleFonts.interTextTheme(
    TextTheme(
      bodyText1: TextStyle(
        fontSize: 16,
        color: Colors.blueGrey[800],
      ),
    ),
  ),
);
