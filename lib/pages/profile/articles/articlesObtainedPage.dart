import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'articleDescriptionPage.dart';

class ArticlesObtainedPage extends StatefulWidget {
  final String uId;

  const ArticlesObtainedPage({Key key, @required this.uId}) : super(key: key);

  @override
  _ArticlesObtainedPageState createState() => _ArticlesObtainedPageState();
}

class _ArticlesObtainedPageState extends State<ArticlesObtainedPage> {
  List _articlesList;

  @override
  void initState() {
    super.initState();

    _articlesList = [];
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

    Widget _myArticles() => Column(
          children: List.generate(
            2,
            (index) => Card(
                elevation: 0.5,
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ArticleDescriptionPage(
                                  uId: widget.uId,
                                  // articleIndex: 0,
                                  articleMap: _articlesList[0]
                                  // TODO: Obtain articles
                              )));
                    },
                    child: ListTile(
                      title: Text('Nashville armchair'),
                      leading: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image:
                            'https://billmes.com/706-large_default/silla-de-ruedas-standard.jpg',
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
                    padding:
                        EdgeInsets.symmetric(horizontal: _screenSizeWidth / 20),
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
