import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../widgets/buttonWidget.dart';
import 'acquireArticle/acquireArticlePage.dart';
import 'acquireArticle/donorContactMenuItemPage.dart';

class ArticleDetailPage extends StatefulWidget {
  final Map articleMap;

  const ArticleDetailPage({Key key, @required this.articleMap})
      : super(key: key);

  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  String _principalImage;
  String _articleName;
  String _articleDescription;
  String _contactUId;

  @override
  void initState() {
    super.initState();

    _contactUId = widget.articleMap['contactUId'];
    _principalImage = widget.articleMap['url'];
    _articleName = widget.articleMap['articleName'];
    _articleDescription = widget.articleMap['description'];
  }

  @override
  Widget build(BuildContext context) {
    final _screenSizeWidth = MediaQuery.of(context).size.width;
    final _fontScaling = MediaQuery.of(context).textScaleFactor;

    Widget _principalPictureContainer() => Container(
          height: _screenSizeWidth / 2,
          width: _screenSizeWidth / 1.2,
          child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(_screenSizeWidth / 20))),
              child: Stack(alignment: Alignment.center, children: <Widget>[
                Center(
                  child: Container(
                      height: _screenSizeWidth / 15,
                      width: _screenSizeWidth / 15,
                      child: CircularProgressIndicator(strokeWidth: 3)),
                ),
                Container(
                    width: _screenSizeWidth,
                    height: _screenSizeWidth / 2,
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: '$_principalImage',
                      fit: BoxFit.scaleDown,
                      placeholderCacheWidth: 100,
                      alignment: Alignment.topCenter,
                    ))
              ])),
        );

    Widget _descriptionContainer() => Container(
          height: _screenSizeWidth / 2,
          width: _screenSizeWidth / 1.2,
          child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(_screenSizeWidth / 8),
                      bottomLeft: Radius.circular(_screenSizeWidth / 8))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('$_articleName',
                        style: TextStyle(
                            fontSize: _fontScaling / 0.05,
                            color: Theme.of(context).primaryColor)),
                    Text('$_articleDescription', textAlign: TextAlign.center)
                  ])),
        );

    Widget _acquireButton() => ButtonWidget(
          buttonText: 'Adquirir',
          elevation: 5.0,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AcquireArticlePage(articleMap: widget.articleMap)));
          },
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
                  actions: [
                    PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert, color: Colors.black),
                        onSelected: (choice) {
                          if (choice == PopupMenuButtonItem.Contact) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DonorContactPage(
                                        contactUId: _contactUId)));
                          } else if (choice == PopupMenuButtonItem.ACQUIRE) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AcquireArticlePage(
                                        articleMap: widget.articleMap)));
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            PopupMenuButtonItem.choices
                                .map((String choice) => PopupMenuItem<String>(
                                      value: choice,
                                      child: Text(choice),
                                    ))
                                .toList())
                  ]),
              body: SingleChildScrollView(
                child: Column(children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: _screenSizeWidth / 20),
                    child: Container(
                        child: Column(children: [
                      SizedBox(height: _screenSizeWidth / 20),
                      _principalPictureContainer(),
                      SizedBox(height: _screenSizeWidth / 9),
                      _descriptionContainer(),
                      SizedBox(height: _screenSizeWidth / 9),
                      _acquireButton(),
                      SizedBox(height: _screenSizeWidth / 9),
                    ])),
                  )
                ]),
              ))),
    );
  }
}

class PopupMenuButtonItem {
  static const String ACQUIRE = 'Adquirir';
  static const String Contact = 'Contactar';

  static const List<String> choices = <String>[ACQUIRE, Contact];
}
