import 'package:flutter/material.dart';
import 'package:staffapp/models/staff_model.dart';
import 'package:staffapp/pages/creation_child_page.dart';


class SelectedStaffMemberPage extends StatelessWidget {
  SelectedStaffMemberPage({Key key, this.staffMemberModel}) : super(key: key);
  final StaffMemberModel staffMemberModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${staffMemberModel.lastName} ${staffMemberModel.firstName}'),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(
                      staffMemberModel.position,
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                      height: 50,
                      width: 174,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              children: <Widget>[],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => CreationChildPage()));
        },
        tooltip: 'Добавление ребенка',
        child: Icon(Icons.person_add),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
