import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staffapp/controller/person_controller.dart';
import 'package:staffapp/models/staff_model.dart';
import 'package:staffapp/pages/selected_staff_page.dart';

import 'children_amount.dart';

class StaffList extends StatefulWidget {
  const StaffList({Key key}) : super(key: key);

  @override
  _StaffListState createState() => _StaffListState();
}

class _StaffListState extends State<StaffList> {
  @override
  Widget build(BuildContext context) {
    final personController = Provider.of<PersonController>(context);
    return StreamBuilder<List<StaffMemberModel>>(
      key: ValueKey('staffStream'),
      stream: personController.getAllStaff(),
      builder: (BuildContext context, AsyncSnapshot<List<StaffMemberModel>> snapshot) {
        if (!snapshot.hasData || snapshot.data.length == 0) return EmptyStaffList();
        return StaffListBuilder(staffList: snapshot);
      },
    );
  }
}

class StaffListBuilder extends StatelessWidget {
  StaffListBuilder({this.staffList});

  final AsyncSnapshot<List<StaffMemberModel>> staffList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      key: PageStorageKey('staffList'),
      itemCount: staffList.data.length,
      itemBuilder: (_, index) {
        final staffMember = staffList.data.elementAt(index);
        return Card(
          child: ListTile(
            key: ValueKey('item$index'),
            dense: false,
            title: Text(
              '${staffMember.lastName} ${staffMember.firstName} ${staffMember.middleName}',
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  staffMember.position,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16),
                ),
                Padding(padding: EdgeInsets.only(left: 12)),
                ChildrenAmount(staffMember.id),
              ],
            ),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => SelectedStaffMemberPage(staffMemberModel: staffMember))),
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
      height: 40,
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          'Сотрудников нет',
          key: ValueKey('emptyStaffList'),
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
