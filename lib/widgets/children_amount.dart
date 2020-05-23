import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staffapp/controller/person_controller.dart';

class ChildrenAmount extends StatelessWidget {
  final String parentId;

  ChildrenAmount(this.parentId);

  @override
  Widget build(BuildContext context) {
    final personController = Provider.of<PersonController>(context);
    return ValueListenableBuilder<Map<String, int>>(
        valueListenable: personController.staffAndChildrenNotifier,
        builder: (_, newAmount, __) {
          return newAmount[parentId] == null ? Text('загрузка...') : Text(
              'Детей: ${newAmount[parentId]}');
        });
  }
}
