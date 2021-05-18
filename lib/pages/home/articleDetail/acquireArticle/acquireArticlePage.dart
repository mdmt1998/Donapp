import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../repositories/globals/sharedPreferences/sharedPrefences.dart';
import '../../../../repositories/articles/articlesRepository.dart';
import '../../../../models/articles/acquireArticleModel.dart';
import '../../../../widgets/buttonWidget.dart';
import 'successfullyAcquirePage.dart';

class AcquireArticlePage extends StatefulWidget {
  final Map articleMap;

  const AcquireArticlePage({Key key, @required this.articleMap})
      : super(key: key);

  @override
  _AcquireArticlePageState createState() => _AcquireArticlePageState();
}

class _AcquireArticlePageState extends State<AcquireArticlePage> {
  ArticlesRepository _articlesRepository = ArticlesRepository();
  SharedPreference _sharedPreference = SharedPreference();

  bool _isloading = false;

  _acquireArticle() async {
    setState(() => _isloading = true);

    var article = AcquireArticleModel(
        url: widget.articleMap['url'],
        description: widget.articleMap['description'],
        articleName: widget.articleMap['articleName'],
        contactUId: widget.articleMap['contactUId'],
        uId: _sharedPreference.uId);

    await _articlesRepository.postAcquireArticle(article);

    setState(() => _isloading = false);
  }

  @override
  void initState() {
    super.initState();

    _sharedPreference.init();
  }

  @override
  Widget build(BuildContext context) {
    final _screenSizeWidth = MediaQuery.of(context).size.width;
    final _fontScaling = MediaQuery.of(context).textScaleFactor;

    Widget _titleText() => Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Resumen',
            style: TextStyle(fontSize: _fontScaling / 0.038),
          ),
        );

    Widget _description() => Card(
          color: Colors.white,
          elevation: 8.0,
          child: Column(
            children: [
              SizedBox(height: _screenSizeWidth / 15),
              Text(widget.articleMap['articleName'],
                  style: TextStyle(
                      fontSize: _fontScaling / 0.04,
                      color: Theme.of(context).primaryColor)),
              Container(
                  width: _screenSizeWidth,
                  height: _screenSizeWidth / 2,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: widget.articleMap['url'],
                    fit: BoxFit.scaleDown,
                    placeholderCacheWidth: 100,
                    alignment: Alignment.topCenter,
                  )),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(widget.articleMap['description'])),
              SizedBox(height: _screenSizeWidth / 20),
            ],
          ),
        );

    Widget _nextButton() => ButtonWidget(
          buttonText: 'Siguiente',
          elevation: 5.0,
          onPressed: () async {
            await _acquireArticle();

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SuccessfullyAcquirePage(
                        contactUId: widget.articleMap['contactUId'])));
          },
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
                body: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: _screenSizeWidth / 20,
                  ),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      _titleText(),
                      SizedBox(height: _screenSizeWidth / 8),
                      _description(),
                      SizedBox(height: _screenSizeWidth / 8),
                      _nextButton(),
                      SizedBox(height: _screenSizeWidth / 8)
                    ],
                  )),
                ),
              ),
      ),
    );
  }
}
