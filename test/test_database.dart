import 'package:staffapp/models/child_model.dart';
import 'package:staffapp/models/staff_model.dart';
import 'package:staffapp/storage/concept_database.dart';

class TestDatabase implements DatabaseConcept {
  List<StaffMemberModel> staffList = [];
  List<ChildModel> childrenList = [];
  Future<Map<String, int>> childrenAndParents = Future.value({});

  @override
  get addChild => (child) async {
        childrenList.add(child);
      };

  @override
  get addStaffMember => (staff) async {
        staffList.add(staff);
      };

  @override
  get amountOfChildrenForEachStaff => () => childrenAndParents;

  @override
  get deleteAllEntries => () {
        staffList = [];
        childrenList = [];
        return Future.value();
      };

  @override
  get getAllStaff => () => Stream.value(staffList);

  @override
  get getParentsChildren => (string) => Stream.value(childrenList);

  @override
  get isChildExists => (string) => Future.value(false);

  @override
  get isStaffExists => (string) => Future.value(false);
}
