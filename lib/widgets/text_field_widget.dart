import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staffapp/controller/person_controller.dart';

class MyTextFieldWidget extends StatelessWidget {
  final String name;
  final DataType dataType;

  final PersonType personType;

  MyTextFieldWidget({
    @required this.name,
    this.dataType,
    this.personType,
  });

  @override
  Widget build(BuildContext context) {
    final staffCreation = Provider.of<PersonController>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: TextFormField(
        maxLength: 14,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          hintText: name,
        ),
        onChanged: (string) {
          staffCreation.addInfo(dataType: dataType, data: string, personType: personType);
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Требуется $name';
          }
          return null;
        },
      ),
    );
  }
}
