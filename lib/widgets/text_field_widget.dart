import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staffapp/controller/staff_controller.dart';

class MyTextFieldWidget extends StatelessWidget {
  final String name;
  final DataType dataType;

//  final MemberType memberType;

  MyTextFieldWidget({
    @required this.name,
    this.dataType,
//    this.memberType,
  });

  @override
  Widget build(BuildContext context) {
    final staffCreation = Provider.of<ManCreation>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: name,
        ),
        onChanged: (string) {
          staffCreation.addInfo(dataType, string);
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
