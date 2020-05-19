class StaffMemberModel {
  final int id;
  final String lastName;
  final String firstName;
  final String middleName;
  final DateTime birthDay;
  final String position;

  StaffMemberModel(this.id, this.lastName, this.firstName, this.middleName, this.birthDay, this.position);
}


Iterable<StaffMemberModel> list = [StaffMemberModel(1, 'Ivanov', 'Ivan', 'Ivanovich', DateTime(1988), 'Programmer')];