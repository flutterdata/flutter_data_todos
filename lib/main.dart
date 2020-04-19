import 'package:flutter/material.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/main.data.dart';

import 'router.gr.dart';

void main() async {
  // specify dependencies and run app
  runApp(MultiProvider(
    providers: [
      ...dataProviders(getApplicationDocumentsDirectory),
    ],
    child: TodoApp(),
  ));
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (context.watch<DataManager>() == null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(child: const CircularProgressIndicator()),
        ),
      );
    }
    return MaterialApp(
      title: 'TO-DO',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Router.onGenerateRoute,
      navigatorKey: Router.navigator.key,
      initialRoute: Router.dashboardScreen,
      theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.firaSansTextTheme(TextTheme(
            body1: TextStyle(
          fontSize: 16,
          color: Colors.blueGrey[800],
        ))),
      ),
    );
  }
}
