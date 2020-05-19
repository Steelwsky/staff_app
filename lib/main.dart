import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [

        ],
        child: MaterialApp(
          title: 'Staff App',
          theme: ThemeData(primarySwatch: Colors.deepPurple),
          home: MyHomePage(),
        ));
  }
}
