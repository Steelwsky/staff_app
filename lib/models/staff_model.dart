class StaffMemberModel {
  final String id;
  final String lastName;
  final String firstName;
  final String middleName;
  final String birthDay;
  final String position;

  StaffMemberModel({this.id, this.lastName, this.firstName, this.middleName, this.birthDay, this.position});
}

final Iterable<StaffMemberModel> staffList = [
  StaffMemberModel(
    lastName: 'Ivanov',
    firstName: 'Ivan',
    middleName: 'Ivanovich',
    birthDay: '1998',
    position: 'Programmer',
  )
];

//enum Position { manager, engineer }

const List<String> positionList = [
  "Инженер",
  "Менеджер"
];
