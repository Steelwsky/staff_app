import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:staffapp/models/child_model.dart';
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

  Future<void> saveChild(ChildModel childModel) async {
    databaseFirestore.collection('children').document().setData({
      'id': childModel.id,
      'parentId': childModel.parentId,
      'lastName': childModel.lastName,
      'firstName': childModel.firstName,
      'middleName': childModel.middleName,
      'birthDay': childModel.birthDay,
    });
  }

  Stream<List<StaffMemberModel>> getAllStaff() {
    return databaseFirestore.collection('savedStaff').snapshots().map((convert) => convert.documents
        .map((item) => StaffMemberModel(
            id: item.data['id'],
            lastName: item.data['lastName'],
            firstName: item.data['firstName'],
            middleName: item.data['middleName'],
            birthDay: item.data['birthDay'],
            position: item.data['position']))
        .toList());
  }

  Stream<List<ChildModel>> getParentsChildren(String parentId) {
    return databaseFirestore.collection('children').where('parentId', isEqualTo: parentId).snapshots().map((convert) =>
        convert.documents
            .map((item) => ChildModel(
                id: item.data['id'],
                parentId: item.data['parentId'],
                lastName: item.data['lastName'],
                firstName: item.data['firstName'],
                middleName: item.data['middleName'],
                birthDay: item.data['birthDay']))
            .toList());
  }

  Future<List<String>> retrieveParentsIds() async {
    final Iterable<String> myParentsList = await databaseFirestore
        .collection('savedStaff')
        .getDocuments()
        .then((onValue) => onValue.documents)
        .then((document) => document.map((d) => d.data['id']));
    print(myParentsList.toList());
    return myParentsList.toList();
  }

  //for app's side calculation
//  Future<List<DocumentSnapshot>> retrieveAllChildren() async {
//    List<DocumentSnapshot> myList = [];
//    await databaseFirestore.collection('children').getDocuments().then((value) => myList = value.documents);
//    return myList;
//  }

  Future<Map<String, int>> receivingParentsAndChildrenAmount() async {
    var listOfParentsAndChildren = await retrieveParentsIds();
    int amount;
    Map<String, int> myMap = {};
    for (var n in listOfParentsAndChildren) {
      await databaseFirestore.collection('children').where('parentId', isEqualTo: n).getDocuments().then((event) {
        amount = event.documents.length;
        print(event.documents.length);
        myMap[n] = amount;
      });
    }
    return myMap;
  }

  Future<bool> isStaffExists(String uuid) async {
    print('isStaffExists $uuid');
    Future<bool> isExists;
    await databaseFirestore.collection('savedStaff').where('id', isEqualTo: uuid).getDocuments().then((event) {
      event.documents.length == 0 ? isExists = Future.value(false) : isExists = Future.value(true);
    });
    return isExists;
  }

  Future<bool> isChildExists(String uuid) async {
    Future<bool> isExists;
    await databaseFirestore.collection('children').where('id', isEqualTo: uuid).getDocuments().then((event) {
      event.documents.length == 0 ? isExists = Future.value(false) : isExists = Future.value(true);
    });
    return isExists;
  }

  Future<void> deleteAllEntries() async {
    await databaseFirestore.collection('savedStaff').getDocuments().then((snapshot) {
      for (DocumentSnapshot doc in snapshot.documents) {
        doc.reference.delete();
      }
    });
    await databaseFirestore.collection('children').getDocuments().then((snapshot) {
      for (DocumentSnapshot doc in snapshot.documents) {
        doc.reference.delete();
      }
    });
  }
}
