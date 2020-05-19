import 'package:flutter/material.dart';
import 'package:staffapp/models/staff_model.dart';

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
      body: Center(
          child: ListView(
              key: PageStorageKey('latest'),
              children: list
                  .toList()
                  .map(
                    (i) => ListTile(
                      title: Text(
                        '${i.lastName} ${i.firstName} ${i.middleName}',
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        i.position,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Icon(Icons.bookmark),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => SelectedStaffMemberPage(staffMemberModel: i)));
                      },
                    ),
                  )
                  .toList())),
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
