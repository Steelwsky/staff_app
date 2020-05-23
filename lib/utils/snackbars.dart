import 'package:flutter/material.dart';

class MySnackbars {

  final snackbarDateFailed = SnackBar(
    content: Text("Укажите дату рождения"),
    duration: Duration(seconds: 2),
  );

  final snackbarStaffSuccess = SnackBar(
    content: Text("Сотрудник добавлен"),
    duration: Duration(seconds: 2),
  );
  
  final snackbarChildSuccess = SnackBar(
    content: Text("Ребенок добавлен"),
    duration: Duration(seconds: 2),
  );

  final snackbarChildExists = SnackBar(
    content: Text("Ребенок уже существует"),
    duration: Duration(seconds: 2),
  );
  
  final snackbarStaffExists = SnackBar(
    content: Text("Сотрудник уже существует"),
    duration: Duration(seconds: 2),
  );
  
  void showStaffSuccessSnackbar(GlobalKey<ScaffoldState> key) {
    key.currentState.showSnackBar(snackbarStaffSuccess);
  }

  void showChildSuccessSnackbar(GlobalKey<ScaffoldState> key) {
    key.currentState.showSnackBar(snackbarChildSuccess);
  }
  
  void showDateFailedSnackbar(GlobalKey<ScaffoldState> key) {
    key.currentState.showSnackBar(snackbarDateFailed);
  }

  void showStaffExistsSnackbar(GlobalKey<ScaffoldState> key) {
    key.currentState.showSnackBar(snackbarStaffExists);
  }

  void showChildExistsSnackbar(GlobalKey<ScaffoldState> key) {
    key.currentState.showSnackBar(snackbarChildExists);
  }
}