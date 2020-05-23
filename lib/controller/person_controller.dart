import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:staffapp/models/child_model.dart';
import 'package:staffapp/models/staff_model.dart';
import 'package:staffapp/storage/concept_database.dart';
import 'package:staffapp/utils/snackbars.dart';
import 'package:uuid/uuid.dart';

class PersonController {
  final DatabaseConcept database;

  PersonController({this.database}) {
    getAmountOfChildrenForEachStaff();
  }

  ValueNotifier<StaffMemberModel> staffMemberNotifier = ValueNotifier(StaffMemberModel(position: positionList.first));

  ValueNotifier<ChildModel> childNotifier = ValueNotifier(ChildModel());

  ValueNotifier<Map<String, int>> staffAndChildrenNotifier = ValueNotifier({});

  MySnackbars mySnackbars = MySnackbars();

  void addInfo({DataType dataType, String data, PersonType personType}) {
    switch (dataType) {
      case DataType.lastName:
        {
          personType == PersonType.staff
              ? staffMemberNotifier.value = StaffMemberModel(
                  lastName: data,
                  firstName: staffMemberNotifier.value.firstName,
                  middleName: staffMemberNotifier.value.middleName,
                  birthDay: staffMemberNotifier.value.birthDay,
                  position: staffMemberNotifier.value.position,
                )
              : childNotifier.value = ChildModel(
                  lastName: data,
                  firstName: childNotifier.value.firstName,
                  middleName: childNotifier.value.middleName,
                  birthDay: childNotifier.value.birthDay,
                );
          break;
        }
      case DataType.firstName:
        {
          personType == PersonType.staff
              ? staffMemberNotifier.value = StaffMemberModel(
                  lastName: staffMemberNotifier.value.lastName,
                  firstName: data,
                  middleName: staffMemberNotifier.value.middleName,
                  birthDay: staffMemberNotifier.value.birthDay,
                  position: staffMemberNotifier.value.position,
                )
              : childNotifier.value = ChildModel(
                  lastName: childNotifier.value.lastName,
                  firstName: data,
                  middleName: childNotifier.value.middleName,
                  birthDay: childNotifier.value.birthDay,
                );
          break;
        }
      case DataType.middleName:
        {
          personType == PersonType.staff
              ? staffMemberNotifier.value = StaffMemberModel(
                  lastName: staffMemberNotifier.value.lastName,
                  firstName: staffMemberNotifier.value.firstName,
                  middleName: data,
                  birthDay: staffMemberNotifier.value.birthDay,
                  position: staffMemberNotifier.value.position,
                )
              : childNotifier.value = ChildModel(
                  lastName: childNotifier.value.lastName,
                  firstName: childNotifier.value.firstName,
                  middleName: data,
                  birthDay: childNotifier.value.birthDay,
                );
          break;
        }
      case DataType.position:
        {
          staffMemberNotifier.value = StaffMemberModel(
            lastName: staffMemberNotifier.value.lastName,
            firstName: staffMemberNotifier.value.firstName,
            middleName: staffMemberNotifier.value.middleName,
            birthDay: staffMemberNotifier.value.birthDay,
            position: data,
          );
          break;
        }
    }
  }

  void addBirthDay(DateTime dateTime, PersonType personType) {
    switch (personType) {
      case PersonType.staff:
        staffMemberNotifier.value = StaffMemberModel(
          lastName: staffMemberNotifier.value.lastName,
          firstName: staffMemberNotifier.value.firstName,
          middleName: staffMemberNotifier.value.middleName,
          birthDay: DateFormat('yyyy-MM-dd').format(dateTime),
          position: staffMemberNotifier.value.position,
        );
        print('addBirthday ${staffMemberNotifier.value.birthDay}');
        break;
      case PersonType.child:
        childNotifier.value = ChildModel(
          lastName: childNotifier.value.lastName,
          firstName: childNotifier.value.firstName,
          middleName: childNotifier.value.middleName,
          birthDay: DateFormat('yyyy-MM-dd').format(dateTime),
        );
        break;
    }
  }

  String _getUuidFromString(String title) => Uuid().v5(title, 'UUID');

  void saveNewStaffMember({GlobalKey<ScaffoldState> key, PersonType type, String parentId}) async {
    switch (type) {
      case PersonType.staff:
        staffMemberNotifier.value = StaffMemberModel(
          id: _getUuidFromString(
              '${staffMemberNotifier.value.lastName}${staffMemberNotifier.value.firstName}${staffMemberNotifier.value.middleName}${staffMemberNotifier.value.birthDay}'),
          lastName: staffMemberNotifier.value.lastName,
          firstName: staffMemberNotifier.value.firstName,
          middleName: staffMemberNotifier.value.middleName,
          birthDay: staffMemberNotifier.value.birthDay,
          position: staffMemberNotifier.value.position,
        );
        if (await isStaffMemberInDatabase(string: staffMemberNotifier.value.id) == false) {
          database.addStaffMember(staffMemberNotifier.value);
          staffAndChildrenNotifier.value[staffMemberNotifier.value.id] = 0;
          staffMemberNotifier.value = StaffMemberModel(position: positionList.first);

          print('saved');
          mySnackbars.showStaffSuccessSnackbar(key);
        } else {
          print('already exists');
          mySnackbars.showStaffExistsSnackbar(key);
        }
        break;
      case PersonType.child:
        childNotifier.value = ChildModel(
          id: _getUuidFromString(
              '${childNotifier.value.lastName}${childNotifier.value.firstName}${childNotifier.value.birthDay}'),
          parentId: parentId,
          lastName: childNotifier.value.lastName,
          firstName: childNotifier.value.firstName,
          middleName: childNotifier.value.middleName,
          birthDay: childNotifier.value.birthDay,
        );
        if (await isChildExists(string: childNotifier.value.id) == false) {
          database.addChild(childNotifier.value);
          getAmountOfChildrenForEachStaff();
          childNotifier.value = ChildModel();
          print('saved');
          mySnackbars.showChildSuccessSnackbar(key);
        } else {
          print('already exists');
          mySnackbars.showChildExistsSnackbar(key);
        }
        break;
    }
  }

  Future<bool> isStaffMemberInDatabase({@required String string}) async {
    print('isStaffMemberDb');
    return await database.isStaffExists(string);
  }

  Future<bool> isChildExists({@required String string}) async {
    return await database.isChildExists(string);
  }

  Stream<List<StaffMemberModel>> getAllStaff() {
    return database.getAllStaff();
  }

  Stream<List<ChildModel>> getParentsChildren(String parentId) {
    return database.getParentsChildren(parentId);
  }

  Future<void> getAmountOfChildrenForEachStaff() async {
    staffAndChildrenNotifier.value = await database.amountOfChildrenForEachStaff();
    print(staffAndChildrenNotifier.value.keys);
  }

  Future<void> deleteAllEntries() async {
    await database.deleteAllEntries();
  }

  void clearStaffInfo() {
    staffMemberNotifier.value = StaffMemberModel(position: positionList.first);
    childNotifier.value = ChildModel();
    print('cleared');
  }
}

class DatePickerController {
  ValueNotifier<DateTime> dateNotifier = ValueNotifier(DateTime(404));

  void onDateChanged(DateTime dateTime) {
    dateNotifier.value = dateTime;
  }
}

enum DataType {
  lastName,
  firstName,
  middleName,
  position,
}

enum PersonType {
  staff,
  child,
}
