import 'package:flutter/material.dart';

class CreationChildPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавление ребенка'),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(
                      'hi',
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                      height: 50,
                      width: 174,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              children: <Widget>[],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
