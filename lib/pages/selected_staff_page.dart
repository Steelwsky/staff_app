import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staffapp/controller/person_controller.dart';
import 'package:staffapp/models/child_model.dart';
import 'package:staffapp/models/staff_model.dart';
import 'package:staffapp/pages/creation_person_page.dart';

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
                    Container(
                      child: Text(
                        '${staffMemberModel.position} ${staffMemberModel.id}',
                        style: TextStyle(fontSize: 16),
                      ),
                      height: 50,
                    ),
                    ChildrenList(parentId: staffMemberModel.id),
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => new CreationPersonPage(
                    personType: PersonType.child,
                    parentId: staffMemberModel.id,
                  )));
        },
        tooltip: 'Добавление ребенка',
        child: Icon(Icons.person_add),
        backgroundColor: Colors.orange,
      ),
    );
  }
}

class ChildrenList extends StatelessWidget {
  final String parentId;

  ChildrenList({this.parentId});

  @override
  Widget build(BuildContext context) {
    final manController = Provider.of<PersonController>(context);
    return StreamBuilder<List<ChildModel>>(
      key: ValueKey('childrenStream'),
      stream: manController.getParentsChildren(parentId),
      builder: (BuildContext context, AsyncSnapshot<List<ChildModel>> snapshot) {
        if (!snapshot.hasData || snapshot.data.length == 0) return EmptyChildrenList();
        return ChildrenListBuilder(childrenList: snapshot);
      },
    );
  }
}

class ChildrenListBuilder extends StatelessWidget {
  final AsyncSnapshot<List<ChildModel>> childrenList;

  ChildrenListBuilder({this.childrenList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      key: PageStorageKey('childrenList'),
      itemCount: childrenList.data.length,
      itemBuilder: (_, index) {
        final child = childrenList.data.elementAt(index);
        return Card(
          child: ListTile(
            key: ValueKey('item$index'),
            dense: false,
            title: Text(
              '${child.lastName} ${child.firstName} ',
              style: TextStyle(fontSize: 18),
            ),
          ),
        );
      },
    );
  }
}

class EmptyChildrenList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 120,
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Text(
          'Детей нет',
          key: ValueKey('emptyChildrenList'),
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
