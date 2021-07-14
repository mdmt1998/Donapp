import 'package:flutter/material.dart';

import '../../repositories/articles/articlesRepository.dart';
import 'articleDetail/articleDetailPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ArticlesRepository _articlesRepository = ArticlesRepository();

  List _articlesList;

  bool _isLoading = false;

  _getArticles() async {
    setState(() => _isLoading = true);

    await _articlesRepository
        .getAllArticles()
        .then((value) => setState(() => _articlesList = value));

    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _articlesList = [];

    _getArticles();
  }

  @override
  Widget build(BuildContext context) {
    final _screenSizeWidth = MediaQuery.of(context).size.width;
    final _fontScaling = MediaQuery.of(context).textScaleFactor;

    Widget _emptyText() => Center(
          child: Text('No hay artículos disponibles',
              style: TextStyle(fontSize: _fontScaling / 0.045)),
        );

    Widget _articlesGrid() => GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          mainAxisSpacing: _screenSizeWidth / 15,
          children: List.generate(
              _articlesList.length ?? 0,
              (index) => Center(
                      child: Container(
                    height: _screenSizeWidth / 1.2,
                    width: _screenSizeWidth / 2.3,
                    child: GestureDetector(
                        child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(_screenSizeWidth / 13))),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: _screenSizeWidth / 3.3,
                                    width: _screenSizeWidth / 3.3,
                                    child: Image(
                                        image: NetworkImage(
                                            _articlesList[index]['url']),
                                        fit: BoxFit.cover),
                                  ),
                                  SizedBox(height: _screenSizeWidth / 40),
                                  Text(_articlesList[index]['articleName'],
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize: _fontScaling / 0.055),
                                      textAlign: TextAlign.center),
                                ])),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ArticleDetailPage(
                                      articleMap: _articlesList[index])));
                        }),
                  ))),
        );

    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            body: _articlesList.isEmpty ? _emptyText() : _articlesGrid());
  }
}
