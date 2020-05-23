import 'package:staffapp/models/child_model.dart';
import 'package:staffapp/models/staff_model.dart';

typedef AddStaffMember = Future<void> Function(StaffMemberModel staffMemberModel);
typedef GetAllStaff = Stream<List<StaffMemberModel>> Function();
typedef IsStaffExists = Future<bool> Function(String string);
typedef AddChild = Future<void> Function(ChildModel childModel);
typedef GetParentsChildren = Stream<List<ChildModel>> Function(String string);
typedef IsChildExists = Future<bool> Function(String string);
typedef DeleteAllEntries = Future<void> Function();
typedef AmountOfChildrenForEachStaff = Future<Map<String, int>> Function();

abstract class DatabaseConcept {
  final AddStaffMember addStaffMember;
  final GetAllStaff getAllStaff;
  final GetParentsChildren getParentsChildren;
  final AddChild addChild;
  final IsChildExists isChildExists;
  final IsStaffExists isStaffExists;
  final DeleteAllEntries deleteAllEntries;
  final AmountOfChildrenForEachStaff amountOfChildrenForEachStaff;

  DatabaseConcept({
    this.addStaffMember,
    this.getAllStaff,
    this.getParentsChildren,
    this.addChild,
    this.isChildExists,
    this.isStaffExists,
    this.deleteAllEntries,
    this.amountOfChildrenForEachStaff,
  });
}
