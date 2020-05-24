import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:staffapp/controller/person_controller.dart';

class MyDatePickerWidget extends StatefulWidget {
  final PersonType personType;

  MyDatePickerWidget(this.personType);

  @override
  _MyDatePickerWidgetState createState() => _MyDatePickerWidgetState();
}

class _MyDatePickerWidgetState extends State<MyDatePickerWidget> {

  @override
  Widget build(BuildContext context) {
    final datePickerController = Provider.of<DatePickerController>(context);
    final staffCreation = Provider.of<PersonController>(context);
    return Padding(
      padding: EdgeInsets.only(top: 4),
      child: Row(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true, minTime: DateTime(1940), maxTime: DateTime(2021), onConfirm: (date) {
                  datePickerController.onDateChanged(date);
                  staffCreation.addBirthDay(date, widget.personType);
                }, currentTime: DateTime.now(), locale: LocaleType.ru);

              }),
          Container(
              width: 294,
              height: 60,
              child: Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ValueListenableBuilder<DateTime>(
                        valueListenable: datePickerController.dateNotifier,
                        builder: (_, dateTime, __) {
                          return Text(
                            dateTime == DateTime(404)
                                ? 'Выберите дату рождения'
                                : DateFormat('yyyy-MM-dd').format(dateTime),
                            style: TextStyle(fontSize: 16),
                          );
                        }),
                    Padding(
                      padding: EdgeInsets.only(top: 14.0),
                      child: Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
