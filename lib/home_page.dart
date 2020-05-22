import 'package:flutter/material.dart';
import 'package:staffapp/models/staff_model.dart';
import 'package:staffapp/widgets/staff_list.dart';

import 'pages/creation_staff_member_page.dart';
import 'pages/selected_staff_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список сотрудников'),
      ),
      body: StaffList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => CreationStaffMemberPage()));
        },
        tooltip: 'Создание нового сотрудника',
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
