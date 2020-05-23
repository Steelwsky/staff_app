import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:staffapp/controller/person_controller.dart';
import 'package:staffapp/models/child_model.dart';
import 'package:staffapp/models/staff_model.dart';
import 'package:staffapp/storage/firestore_service.dart';

import 'home_page.dart';

typedef AddStaffMember = Future<void> Function(StaffMemberModel staffMemberModel);
typedef GetAllStaff = Stream<List<StaffMemberModel>> Function();
typedef IsStaffExists = Future<bool> Function(String string);
typedef AddChild = Future<void> Function(ChildModel childModel);
typedef GetParentsChildren = Stream<List<ChildModel>> Function(String string);
typedef IsChildExists = Future<bool> Function(String string);
typedef DeleteAllEntries = Future<void> Function();
typedef AmountOfChildrenForEachStaff = Future<Map<String, int>> Function();
//typedef RetrieveParentsIds = Future<List<String>> Function();

abstract class DatabaseConcept {
  final AddStaffMember addStaffMember;
  final GetAllStaff getAllStaff;
  final GetParentsChildren getParentsChildren;
  final AddChild addChild;
  final IsChildExists isChildExists;
  final IsStaffExists isStaffExists;
  final DeleteAllEntries deleteAllEntries;
  final AmountOfChildrenForEachStaff amountOfChildrenForEachStaff;
//  final RetrieveParentsIds retrieveParentsIds;

  DatabaseConcept(
      {this.addStaffMember,
      this.getAllStaff,
      this.getParentsChildren,
      this.addChild,
      this.isChildExists,
      this.isStaffExists,
      this.deleteAllEntries,
      this.amountOfChildrenForEachStaff,
      });
}

class ProductionDatabase implements DatabaseConcept {
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();

  @override
  AddStaffMember get addStaffMember => firestoreDatabase.saveStaffMember;

  @override
  GetAllStaff get getAllStaff => firestoreDatabase.getAllStaff;

  @override
  IsStaffExists get isStaffExists => firestoreDatabase.isStaffExists;

  @override
  DeleteAllEntries get deleteAllEntries => firestoreDatabase.deleteAllEntries;

  @override
  AddChild get addChild => firestoreDatabase.saveChild;

  @override
  GetParentsChildren get getParentsChildren => firestoreDatabase.getParentsChildren;

  @override
  IsChildExists get isChildExists => firestoreDatabase.isChildExists;

  @override
  AmountOfChildrenForEachStaff get amountOfChildrenForEachStaff => firestoreDatabase.receivingParentsAndChildrenAmount;

//  @override
//  RetrieveParentsIds get retrieveParentsIds => firestoreDatabase.retrieveParentsIds;
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
