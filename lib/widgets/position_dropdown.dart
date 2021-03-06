import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staffapp/controller/person_controller.dart';
import 'package:staffapp/models/staff_model.dart';

class MyDropdownPosition extends StatefulWidget {
  final DataType dataType;

  MyDropdownPosition({this.dataType});

  @override
  _MyDropdownPositionState createState() => _MyDropdownPositionState();
}

class _MyDropdownPositionState extends State<MyDropdownPosition> {
  var _currentSelectedValue = positionList.first;

  @override
  Widget build(BuildContext context) {
    final staffCreation = Provider.of<PersonController>(context);
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return DropdownButtonHideUnderline(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InputDecorator(
              decoration: InputDecoration(
                filled: false,
                hintText: 'Выберите должность',
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: DropdownButton<String>(
                  value: _currentSelectedValue,
                  isDense: true,
                  onChanged: (String newValue) {
                    staffCreation.addInfo(dataType: widget.dataType, data: newValue);
                    setState(() {
                      _currentSelectedValue = newValue;
                    });
                  },
                  items: positionList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ));
      },
    );
  }
}
