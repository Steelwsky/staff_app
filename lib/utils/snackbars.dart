import 'package:flutter/material.dart';

class MySnackbars {

  final snackbarDateFailed = SnackBar(
    content: Text("Укажите дату рождения"),
    duration: Duration(seconds: 2),
  );

  final snackbarSuccess = SnackBar(
    content: Text("Сотрудник добавлен"),
    duration: Duration(seconds: 2),
  );

  final snackbarStaffExists = SnackBar(
    content: Text("Сотрудник уже существует"),
    duration: Duration(seconds: 2),
  );
  
  void showSuccessSnackbar(GlobalKey<ScaffoldState> key) {
    key.currentState.showSnackBar(snackbarSuccess);
  }
  
  void showDateFailedSnackbar(GlobalKey<ScaffoldState> key) {
    key.currentState.showSnackBar(snackbarDateFailed);
  }
  
  void showStaffExistsSnackbar(GlobalKey<ScaffoldState> key) {
    key.currentState.showSnackBar(snackbarStaffExists);
  }
}