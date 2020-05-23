import 'concept_database.dart';
import 'firestore_service.dart';

class ProductionDatabase implements DatabaseConcept {
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();

  @override
  AddStaffMember get addStaffMember => firestoreDatabase.saveStaffMember;

  @override
  GetAllStaff get getAllStaff => firestoreDatabase.getAllStaff;

  @override
  IsStaffExists get isStaffExists => firestoreDatabase.isStaffExists;

  @override
  DeleteAllEntries get deleteAllEntries => firestoreDatabase.deleteAllEntries;

  @override
  AddChild get addChild => firestoreDatabase.saveChild;

  @override
  GetParentsChildren get getParentsChildren => firestoreDatabase.getParentsChildren;

  @override
  IsChildExists get isChildExists => firestoreDatabase.isChildExists;

  @override
  AmountOfChildrenForEachStaff get amountOfChildrenForEachStaff => firestoreDatabase.receivingParentsAndChildrenAmount;
}
