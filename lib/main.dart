import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'controller/person_controller.dart';
import 'home_page.dart';
import 'storage/concept_database.dart';
import 'storage/production_database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final DatabaseConcept firestore = ProductionDatabase();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(MyApp(database: firestore)));
}

class MyApp extends StatefulWidget {
  final DatabaseConcept database;

  MyApp({this.database});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PersonController>(create: (_) => PersonController(database: widget.database)),
      ],
      child: MaterialApp(
        title: 'Staff App',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: MyHomePage(),
        initialRoute: '/',
      ),
    );
  }
}
