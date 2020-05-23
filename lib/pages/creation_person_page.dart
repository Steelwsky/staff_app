import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staffapp/controller/person_controller.dart';
import 'package:staffapp/utils/snackbars.dart';
import 'package:staffapp/widgets/date_picker_widget.dart';
import 'package:staffapp/widgets/position_dropdown.dart';
import 'package:staffapp/widgets/text_field_widget.dart';

class CreationPersonPage extends StatelessWidget {
  final PersonType personType;

  final String parentId;

  CreationPersonPage({
    this.personType,
    this.parentId,
  });

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final personController = Provider.of<PersonController>(context);
    final MySnackbars mySnackbars = MySnackbars();
    personController.clearStaffInfo();
    return MultiProvider(
      providers: [
        Provider<DatePickerController>(create: (_) => DatePickerController()),
      ],
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: personType == PersonType.staff ? Text('Создание сотрудника') : Text('Добавление ребенка'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              scrollDirection:  Axis.vertical,
              children: <Widget>[
                MyTextFieldWidget(
                  name: 'Фамилия',
                  dataType: DataType.lastName,
                  personType: personType,
                ),
                MyTextFieldWidget(
                  name: 'Имя',
                  dataType: DataType.firstName,
                  personType: personType,
                ),
                MyTextFieldWidget(
                  name: 'Отчество',
                  dataType: DataType.middleName,
                  personType: personType,
                ),
                MyDatePickerWidget(personType),
                personType == PersonType.staff
                    ? MyDropdownPosition(
                        dataType: DataType.position,
                      )
                    : SizedBox.shrink(),
                Padding(
                  padding: EdgeInsets.only(top: 14.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        RaisedButton(
                            child: Text(
                              'Сохранить',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.deepPurple,
                            onPressed: () {
                              switch (personType) {
                                case PersonType.staff:
                                  {
                                    if (personController.staffMemberNotifier.value.birthDay == null) {
                                      mySnackbars.showDateFailedSnackbar(_scaffoldKey);
                                    }
                                    if (_formKey.currentState.validate() &&
                                        personController.staffMemberNotifier.value.birthDay != null) {
                                      personController.saveNewStaffMember(key: _scaffoldKey, type: personType);
                                      Future.delayed(Duration(seconds: 2), () {
                                        Navigator.pop(context);
                                      });
                                    }
                                    break;
                                  }
                                case PersonType.child:
                                  {
                                    if (personController.childNotifier.value.birthDay == null) {
                                      mySnackbars.showDateFailedSnackbar(_scaffoldKey);
                                    }
                                    if (_formKey.currentState.validate() &&
                                        personController.childNotifier.value.birthDay != null) {
                                      personController.saveNewStaffMember(
                                          key: _scaffoldKey, type: personType, parentId: parentId);
                                      Future.delayed(Duration(seconds: 2), () {
                                        Navigator.pop(context);
                                      });
                                    }
                                    break;
                                  }
                              }
                            }),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
