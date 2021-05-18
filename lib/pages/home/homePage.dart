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

  bool _isloading = false;

  _getArticles() async {
    setState(() => _isloading = true);

    await _articlesRepository
        .getAllArticles()
        .then((value) => setState(() => _articlesList = value));

    setState(() => _isloading = false);
  }

  @override
  void initState() {
    super.initState();
    _articlesList = [];

    _getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return _isloading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            body: Center(
            child: ArticlesGridViewWidget(articlesList: _articlesList),
          ));
  }
}
