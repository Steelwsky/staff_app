import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:staffapp/main.dart';
import 'package:staffapp/models/staff_model.dart';
import 'package:uuid/uuid.dart';

class ManCreation {
  final DatabaseConcept database;

  ManCreation({this.database});

  ValueNotifier<StaffMemberModel> staffMemberNotifier = ValueNotifier(StaffMemberModel(position: positionList.first));

  void addInfo(DataType dataType, String data) {
    switch (dataType) {
      case DataType.lastName:
        {
//          dataType == DataType.lastName ? :
          staffMemberNotifier.value = StaffMemberModel(
            lastName: data,
            firstName: staffMemberNotifier.value.firstName,
            middleName: staffMemberNotifier.value.middleName,
            birthDay: staffMemberNotifier.value.birthDay,
            position: staffMemberNotifier.value.position,
          );
          break;
        }
      case DataType.firstName:
        {
          staffMemberNotifier.value = StaffMemberModel(
            lastName: staffMemberNotifier.value.lastName,
            firstName: data,
            middleName: staffMemberNotifier.value.middleName,
            birthDay: staffMemberNotifier.value.birthDay,
            position: staffMemberNotifier.value.position,
          );
          break;
        }
      case DataType.middleName:
        {
          staffMemberNotifier.value = StaffMemberModel(
            lastName: staffMemberNotifier.value.lastName,
            firstName: staffMemberNotifier.value.firstName,
            middleName: data,
            birthDay: staffMemberNotifier.value.birthDay,
            position: staffMemberNotifier.value.position,
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

  void addBirthDay(DateTime dateTime) {
    staffMemberNotifier.value = StaffMemberModel(
      lastName: staffMemberNotifier.value.lastName,
      firstName: staffMemberNotifier.value.firstName,
      middleName: staffMemberNotifier.value.middleName,
      birthDay: DateFormat('yyyy-MM-dd').format(dateTime),
      position: staffMemberNotifier.value.position,
    );
    print('addBirthday ${staffMemberNotifier.value.birthDay}');
  }

  String _getUuidFromString(String title) => Uuid().v5(title, 'UUID');

  void saveNewStaffMember(GlobalKey<ScaffoldState> key) async {
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
      staffMemberNotifier.value = StaffMemberModel(position: positionList.first);
      print('saved');
      key.currentState.showSnackBar(snackbarSuccess);
    } else {
      print('already exists');
      key.currentState.showSnackBar(snackbarExists);
    }
  }

  void clearStaffInfo() {
    staffMemberNotifier.value = StaffMemberModel(position: positionList.first);
    print('cleared');
  }

  Future<bool> isStaffMemberInDatabase({@required String string}) {
    return database.isStaffExists(string);
  }

  Stream<List<StaffMemberModel>> getAllStaff() {
    print('getAll called');
    return database.getAllStaff();
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

final snackbarDateFailed = SnackBar(
  content: Text("Укажите дату рождения"),
  duration: Duration(seconds: 2),
);

final snackbarSuccess = SnackBar(
  content: Text("Сотрудник добавлен"),
  duration: Duration(seconds: 2),
);

final snackbarExists = SnackBar(
  content: Text("Сотрудник уже существует"),
  duration: Duration(seconds: 2),
);
