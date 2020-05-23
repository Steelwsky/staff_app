import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staffapp/controller/person_controller.dart';
import 'package:staffapp/widgets/staff_list.dart';

import 'pages/creation_person_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final personCreation = Provider.of<PersonController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Список сотрудников'),
        actions: <Widget>[
          IconButton(
            key: ValueKey('deleteIcon'),
            icon: Icon(Icons.delete),
            onPressed: personCreation.deleteAllEntries,
          ),
        ],
      ),
      body: StaffList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => CreationPersonPage(personType: PersonType.staff)));
        },
        tooltip: 'Создание нового сотрудника',
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
