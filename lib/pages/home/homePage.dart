import 'package:flutter/material.dart';

import '../../widgets/articlesGridViewWidget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ArticlesGridViewWidget(
              articleImage:
                  'https://billmes.com/706-large_default/silla-de-ruedas-standard.jpg',
              articleName: 'Nombre')),
    );
  }
}
