import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staffapp/controller/staff_controller.dart';
import 'package:staffapp/models/staff_model.dart';
import 'package:staffapp/pages/selected_staff_page.dart';

class StaffList extends StatelessWidget {
  const StaffList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final manController = Provider.of<ManCreation>(context);
    return StreamBuilder(
      key: ValueKey('historyPage'),
      stream: manController.getAllStaff(),
      builder: (BuildContext context, AsyncSnapshot<List<StaffMemberModel>> snapshot) {
        if (!snapshot.hasData || snapshot.data.isEmpty) return EmptyStaffList();
        return StaffListBuilder(history: snapshot);
      },
    );
  }
}

class StaffListBuilder extends StatelessWidget {
  StaffListBuilder({this.history});

  final AsyncSnapshot<List<StaffMemberModel>> history;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: PageStorageKey('historyNewsPage'),
      itemCount: history.data.length,
      itemBuilder: (_, index) {
        final staffMember = history.data.elementAt(index);
        return Card(
          child: ListTile(
            key: ValueKey('item$index'),
            dense: false,
            title: Text(
              '${staffMember.lastName} ${staffMember.firstName} ',
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Row(
              children: <Widget>[
                Text(
                  staffMember.position,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            trailing: null,
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SelectedStaffMemberPage(staffMemberModel: staffMember)));
            },
          ),
        );
      },
    );
  }
}

class EmptyStaffList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Text(
          'Сотрудников нет',
          key: ValueKey('emptyHistory'),
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
