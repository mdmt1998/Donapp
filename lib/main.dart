import 'package:flutter/material.dart';

import 'widgets/hiddenDrawerMenu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DonApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HiddenDrowerMenu(),
    );
  }
}
