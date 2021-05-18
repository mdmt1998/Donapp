import 'package:flutter/material.dart';

import '../../repositories/articles/articlesRepository.dart';
import '../../widgets/articlesGridViewWidget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ArticlesRepository _articlesRepository = ArticlesRepository();

  List _articlesList;

  _getArticles() async {
    await _articlesRepository
        .getAllArticles()
        .then((value) => setState(() => _articlesList = value));
  }

  @override
  void initState() {
    super.initState();
    _articlesList = [];

    _getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ArticlesGridViewWidget(articlesList: _articlesList),
    ));
  }
}
