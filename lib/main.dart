import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_data_state/flutter_data_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:todos/main.data.dart';

import 'models/todo.dart';
import 'models/user.dart';

main() {
  runApp(MultiProvider(
    providers: [
      ...dataProviders(() => getApplicationDocumentsDirectory()),
    ],
    child: TodoApp(),
  ));
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Builder(
            builder: (context) {
              if (context.watch<DataManager>() == null) {
                return const CircularProgressIndicator();
              }
              return TodoScreen();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Todo(title: "Task number ${Random().nextInt(9999)}").save();
            // Todo(id: 1, title: "OVERWRITING TASK!", completed: true).save();
          },
          child: Icon(Icons.add),
        ),
      ),
      theme: theme,
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final repository = context.read<Repository<Todo>>();
    return DataStateBuilder<List<Todo>>(
      notifier: repository.watchAll(params: {'userId': '1', '_limit': '5'}),
      builder: (context, state, notifier, _) {
        return RefreshIndicator(
          onRefresh: () async {
            await notifier.reload();
          },
          child: TodoList(state),
        );
      },
    );
  }
}

class TodoList extends StatelessWidget {
  final DataState<List<Todo>> state;
  const TodoList(this.state, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return Center(child: const CircularProgressIndicator());
    }
    return ListView.separated(
      itemBuilder: (context, i) {
        final todo = state.model[i];
        return GestureDetector(
          onDoubleTap: () =>
              Todo(id: todo.id, title: todo.title, completed: !todo.completed)
                  .save(),
          child: Dismissible(
            child: Text(
                '${todo.completed ? "✅" : "◻️"} [id: ${todo.id}] ${todo.title}'),
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
      itemCount: state.model.length,
      separatorBuilder: (context, i) => Divider(),
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
    );
  }
}

final theme = ThemeData.light().copyWith(
  textTheme: GoogleFonts.interTextTheme(
    TextTheme(
      body1: TextStyle(
        fontSize: 16,
        color: Colors.blueGrey[800],
      ),
    ),
  ),
);
