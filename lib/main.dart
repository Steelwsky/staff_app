import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:staffapp/controller/staff_controller.dart';
import 'package:staffapp/models/staff_model.dart';
import 'package:staffapp/storage/firestore_service.dart';

import 'home_page.dart';

typedef AddStaffMember = Future<void> Function(StaffMemberModel staffMemberModel);
typedef GetAllStaff = Stream<List<StaffMemberModel>> Function();
typedef IsStaffExists = Future<bool> Function(String string);

abstract class DatabaseConcept {
  final AddStaffMember addStaffMember;
  final GetAllStaff getAllStaff;
  final IsStaffExists isStaffExists;

  DatabaseConcept({this.addStaffMember, this.getAllStaff, this.isStaffExists});
}

class ProductionDatabase implements DatabaseConcept {
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();

  @override
  AddStaffMember get addStaffMember => firestoreDatabase.saveStaffMember;

  @override
  GetAllStaff get getAllStaff => firestoreDatabase.getAllStaff;

  @override
  IsStaffExists get isStaffExists => firestoreDatabase.isStaffExists;
}

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
          Provider<ManCreation>(create: (_) => ManCreation(database: widget.database)),
        ],
        child: MaterialApp(
          title: 'Staff App',
          theme: ThemeData(primarySwatch: Colors.deepPurple),
          home: MyHomePage(),
          initialRoute: '/',
        ),);
  }
}
