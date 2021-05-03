import 'package:flutter/material.dart';

import '../pages/home/articleDetail/articleDetailPage.dart';

class ArticlesGridViewWidget extends StatefulWidget {
  final String articleImage;
  final String articleName;

  const ArticlesGridViewWidget({
    Key key,
    @required this.articleImage,
    @required this.articleName,
  }) : super(key: key);

  @override
  _ArticlesGridViewWidgetState createState() => _ArticlesGridViewWidgetState();
}

class _ArticlesGridViewWidgetState extends State<ArticlesGridViewWidget> {
  @override
  Widget build(BuildContext context) {
    final _screenSizeWidth = MediaQuery.of(context).size.width;
    final _fontScaling = MediaQuery.of(context).textScaleFactor;

    /**
     *
     */
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        mainAxisSpacing: _screenSizeWidth / 15,
        children: List.generate(7, (index) {
          return Center(
              child: Container(
            height: _screenSizeWidth / 1.2,
            width: _screenSizeWidth / 2.6,
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
                          height: _screenSizeWidth / 3.8,
                          width: _screenSizeWidth / 3.8,
                          child: Image(
                            image: NetworkImage(widget.articleImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text('${widget.articleName}',
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: _fontScaling / 0.080),
                            textAlign: TextAlign.center),
                      ])),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ArticleDetailPage()),
                );
              },
            ),
          ));
        }),
      ),
    );
  }
}
