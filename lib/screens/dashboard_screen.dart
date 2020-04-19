import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_data_state/flutter_data_state.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/models/user.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var _currentIndex = 0;
  final List<Widget> _children = [
    TodoScreen(),
    PostsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (int index) => setState(() => _currentIndex = index),
        selectedFontSize: 12,
        unselectedLabelStyle: TextStyle(height: 1.3),
        selectedLabelStyle: TextStyle(height: 1.3),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_today),
            title: const Text('TO-DOs'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.note),
            title: const Text('Posts'),
          )
        ],
      ),
      body: _children[_currentIndex],
    );
  }
}

class TodoScreen extends StatelessWidget {
  final emoji = EmojiParser();

  @override
  Widget build(BuildContext context) {
    final notifier = context
        .read<Repository<Todo>>()
        .watchAll(params: {'userId': '1', '_limit': '5'});
    return Scaffold(
      appBar: AppBar(
        title: const Text('TO-DOs'),
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await notifier.reload();
        },
        child: DataStateBuilder<List<Todo>>(
          notifier: notifier,
          builder: (context, state, _) {
            if (state.isLoading) {
              return Center(child: const CircularProgressIndicator());
            }
            final model = state.model
              ..sort((a, b) {
                if (a.id == null || b.id == null) return -1;
                return a.id.compareTo(b.id);
              });
            return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              itemBuilder: (BuildContext context, int index) {
                final todo = model[index];
                return GestureDetector(
                  onDoubleTap: () =>
                      todo.copyWith(completed: !todo.completed).save(),
                  child: Dismissible(
                    key: ValueKey(todo),
                    direction: DismissDirection.endToStart,
                    child: Builder(
                      builder: (context) {
                        final check = todo.completed
                            ? emoji.get(':white_check_mark:').code
                            : emoji.get(':white_medium_square:').code;
                        return Text('$check ${todo.title} (id: ${todo.id})');
                      },
                    ),
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
              itemCount: model.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Todo(title: "Task number ${Random().nextInt(9999)}").save();
          Todo(id: 1, title: "OVERWRITING TASK!", completed: true).save();
        },
        backgroundColor: Colors.blueAccent,
        //if you set mini to true then it will make your floating button small
        mini: false,
        child: new Icon(Icons.add),
      ),
    );
  }
}

class PostsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<User>(
        future: context
            .read<Repository<User>>()
            .findOne(1, params: {'_embed': 'posts'}),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: const CircularProgressIndicator());
          }
          return ListView.separated(
            padding: EdgeInsets.only(left: 10),
            itemBuilder: (BuildContext context, int index) {
              return Text('Post: ${snapshot.data.posts[index].title}');
            },
            itemCount: snapshot.data.posts.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
        },
      ),
    );
  }
}
