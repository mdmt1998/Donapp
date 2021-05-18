import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../repositories/articles/articlesRepository.dart';
import 'articleDescriptionPage.dart';
import 'publishArticlePage.dart';

class ArticlesPublishedPage extends StatefulWidget {
  final String uId;

  const ArticlesPublishedPage({Key key, @required this.uId}) : super(key: key);

  @override
  _ArticlesPublishedPageState createState() => _ArticlesPublishedPageState();
}

class _ArticlesPublishedPageState extends State<ArticlesPublishedPage> {
  ArticlesRepository _articlesRepository = ArticlesRepository();

  List _articlesList;

  bool _isloading = false;

  _getArticles() async {
    setState(() => _isloading = true);

    await _articlesRepository
        .getPublishedArticlesByUid(widget.uId)
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
    final _screenSizeWidth = MediaQuery.of(context).size.width;
    final _fontScaling = MediaQuery.of(context).textScaleFactor;

    Widget _titleText() => Container(
          alignment: Alignment.centerLeft,
          child: Text('Artículos publicados',
              style: TextStyle(fontSize: _fontScaling / 0.04)),
        );

    Widget _addArticle() => Card(
          elevation: 0.5,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PublishArticlePage(uId: widget.uId)));
            },
            child: ListTile(
                title: Text('Publicar artículo'),
                leading: Icon(Icons.post_add, color: Colors.green),
                trailing:
                    Icon(Icons.arrow_forward_ios, size: _screenSizeWidth / 25)),
          ),
        );

    Widget _nonPublishedArticles() => Container(
          alignment: Alignment.centerLeft,
          child:
              Text('No tienes artículos publicados', textAlign: TextAlign.left),
        );

    Widget _publishedArticles() => _articlesList.isEmpty
        ? _nonPublishedArticles()
        : Column(
            children: List.generate(
              _articlesList.length ?? 0,
              (index) => Card(
                  elevation: 0.5,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ArticleDescriptionPage(
                                    articleMap: _articlesList[index])));
                      },
                      child: ListTile(
                        title: Text(_articlesList[index]['articleName']),
                        leading: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: _articlesList[index]['url'],
                          fit: BoxFit.scaleDown,
                          placeholderCacheWidth: 100,
                          alignment: Alignment.topCenter,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                            size: _screenSizeWidth / 25),
                      ))),
            ),
          );

    /**
     *
     */
    return Container(
      color: Colors.white,
      child: SafeArea(
          bottom: false,
          child: _isloading
              ? Center(child: CircularProgressIndicator())
              : Scaffold(
                  appBar: AppBar(
                    elevation: 0.0,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  body: SingleChildScrollView(
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: _screenSizeWidth / 20),
                        child: Container(
                            child: Column(children: [
                          _titleText(),
                          SizedBox(height: _screenSizeWidth / 13),
                          _addArticle(),
                          SizedBox(height: _screenSizeWidth / 20),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                  height: _screenSizeWidth / 700.0,
                                  color: Colors.grey[400])),
                          SizedBox(height: _screenSizeWidth / 20),
                          _publishedArticles(),
                          SizedBox(height: _screenSizeWidth / 9),
                        ])),
                      )
                    ]),
                  ))),
    );
  }
}
