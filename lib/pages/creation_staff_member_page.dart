import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staffapp/controller/staff_controller.dart';
import 'package:staffapp/utils/snackbars.dart';
import 'package:staffapp/widgets/date_picker_widget.dart';
import 'package:staffapp/widgets/position_dropdown.dart';
import 'package:staffapp/widgets/text_field_widget.dart';

class CreationStaffMemberPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final staffCreation = Provider.of<PersonCreation>(context);
    final MySnackbars mySnackbars = MySnackbars();
    staffCreation.clearStaffInfo();
    return MultiProvider(
      providers: [
        Provider<DatePickerController>(create: (_) => DatePickerController()),
      ],
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Создание сотрудника'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MyTextFieldWidget(
                  name: 'Фамилия',
                  dataType: DataType.lastName,
                  //todo add personType
                ),
                MyTextFieldWidget(
                  name: 'Имя',
                  dataType: DataType.firstName,
                ),
                MyTextFieldWidget(
                  name: 'Отчество',
                  dataType: DataType.middleName,
                ),
                MyDatePickerWidget(),
                MyDropdownPosition(
                  dataType: DataType.position,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24.0),
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
                              if (staffCreation.staffMemberNotifier.value.birthDay == null) {
                                print('birthday null');
                                mySnackbars.showDateFailedSnackbar(_scaffoldKey);
                              }
                              if (_formKey.currentState.validate() &&
                                  staffCreation.staffMemberNotifier.value.birthDay != null) {
                                print('all good');
                                staffCreation.saveNewStaffMember(_scaffoldKey);
                                Future.delayed(Duration(seconds: 2), () {
                                  Navigator.pop(context);
                                });
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
