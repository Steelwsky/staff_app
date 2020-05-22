import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:staffapp/models/staff_model.dart';

class FirestoreDatabase {
  FirestoreDatabase._();

  static final FirestoreDatabase _instance = FirestoreDatabase._();

  factory FirestoreDatabase() {
    return _instance;
  }

  final databaseFirestore = Firestore.instance;


  Future<void> saveStaffMember(StaffMemberModel staffMemberModel) async {
    databaseFirestore.collection('savedStaff').document().setData({
      'id': staffMemberModel.id,
      'lastName': staffMemberModel.lastName,
      'firstName': staffMemberModel.firstName,
      'middleName': staffMemberModel.middleName,
      'birthDay': staffMemberModel.birthDay,
      'position': staffMemberModel.position,
    });
  }

  Stream<List<StaffMemberModel>> getAllStaff() {
    return databaseFirestore.collection('savedStaff').snapshots().map((convert) =>
        convert.documents
            .map((item) =>
            StaffMemberModel(
                id: item.data['id'],
                lastName: item.data['lastName'],
                firstName: item.data['firstName'],
                middleName: item.data['middleName'],
                birthDay: item.data['birthDay'],
                position: item.data['position']))
            .toList());
  }

  Future<bool> isStaffExists(String uuid) async{
    Future<bool> isExists;
//    databaseFirestore.collection('savedStaff').where('id', isEqualTo: uuid).snapshots().listen((event) {
//      event.documents.length == 0 ? isExists = Future.value(false) : isExists = Future.value(true);
//    });
    await databaseFirestore.collection('savedStaff').where('id', isEqualTo: uuid).getDocuments().then((event) {
      event.documents.length == 0 ? isExists = Future.value(false) : isExists = Future.value(true);
    });
    return isExists;
  }


}
