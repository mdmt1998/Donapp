import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../repositories/articles/articlesRepository.dart';
import 'articleDescriptionPage.dart';

class ArticlesObtainedPage extends StatefulWidget {
  final String uId;

  const ArticlesObtainedPage({Key key, @required this.uId}) : super(key: key);

  @override
  _ArticlesObtainedPageState createState() => _ArticlesObtainedPageState();
}

class _ArticlesObtainedPageState extends State<ArticlesObtainedPage> {
  ArticlesRepository _articlesRepository = ArticlesRepository();

  List _articlesList;

  bool _isloading = false;

  _getArticles() async {
    setState(() => _isloading = true);

    await _articlesRepository
        .getObtainedArticleByUid(widget.uId)
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
          child: Text(
            'Artículos adquiridos',
            style: TextStyle(fontSize: _fontScaling / 0.04),
          ),
        );

    Widget _nonAcquiredArticles() => Container(
          alignment: Alignment.centerLeft,
          child: Text('No has adquirido artículos', textAlign: TextAlign.left),
        );

    Widget _myArticles() => _articlesList.isEmpty
        ? _nonAcquiredArticles()
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
      child: _isloading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              bottom: false,
              child: Scaffold(
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
                          _myArticles(),
                          SizedBox(height: _screenSizeWidth / 9),
                        ])),
                      )
                    ]),
                  ))),
    );
  }
}
