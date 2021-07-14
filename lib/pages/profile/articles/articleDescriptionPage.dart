import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/articles/acquireArticleModel.dart';
import '../../../models/auth/userDataModel.dart';
import '../../../repositories/articles/articlesRepository.dart';
import '../../../repositories/globals/constants/constants.dart';
import '../../../repositories/profile/profileRepository.dart';
import '../../../widgets/hiddenDrawerMenu.dart';

class ArticleDescriptionPage extends StatefulWidget {
  final Map articleMap;
  final bool isPublished;

  const ArticleDescriptionPage(
      {Key key, @required this.articleMap, @required this.isPublished})
      : super(key: key);

  @override
  _ArticleDescriptionPageState createState() => _ArticleDescriptionPageState();
}

class _ArticleDescriptionPageState extends State<ArticleDescriptionPage> {
  ArticlesRepository _articlesRepository = ArticlesRepository();
  ProfileRepository _profileRepository = ProfileRepository();
  UserData _contactData = UserData();

  bool _isLoading = false;

  _getContactInformation() async {
    setState(() => _isLoading = true);

    await _profileRepository
        .getUserData(widget.articleMap['contactUId'])
        .then((value) => setState(() => _contactData = value));

    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();

    _getContactInformation();
  }

  @override
  Widget build(BuildContext context) {
    final _screenSizeWidth = MediaQuery.of(context).size.width;
    final _fontScaling = MediaQuery.of(context).textScaleFactor;

    Widget _buildPopupDialog(String body, bool success) => AlertDialog(
          title: Text('Detalle de artículo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(body),
            ],
          ),
          actions: [
            FlatButton(
              child: Text('Ok'),
              textColor: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );

    Widget _titleText() => Container(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.articleMap['articleName'],
            style: TextStyle(fontSize: _fontScaling / 0.04),
          ),
        );

    Widget _image() => FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: widget.articleMap['url'],
          fit: BoxFit.scaleDown,
          placeholderCacheWidth: 100,
          alignment: Alignment.topCenter,
        );

    Widget _description() => Center(
          child: Text(widget.articleMap['description']),
        );

    Widget _contact() => Card(
          color: Colors.white,
          elevation: 4.0,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Contacto',
                        style: TextStyle(
                            fontSize: _fontScaling / 0.04,
                            color: Theme.of(context).primaryColor)),
                    SizedBox(height: _screenSizeWidth / 15),
                    Text(_contactData?.name,
                        style: TextStyle(fontSize: _fontScaling / 0.065)),
                    SizedBox(height: _screenSizeWidth / 15),
                    Text(_contactData?.address,
                        style: TextStyle(fontSize: _fontScaling / 0.065)),
                    SizedBox(height: _screenSizeWidth / 65),
                    Text(_contactData?.city,
                        style: TextStyle(fontSize: _fontScaling / 0.065)),
                    SizedBox(height: _screenSizeWidth / 15),
                    Text(_contactData?.email,
                        style: TextStyle(fontSize: _fontScaling / 0.065)),
                    SizedBox(height: _screenSizeWidth / 65),
                    FlatButton(
                        child: Text('(+57) ${_contactData?.phoneNumber}',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: _fontScaling / 0.065)),
                        onPressed: () =>
                            launch('tel://${_contactData?.phoneNumber}'))
                  ],
                )),
          ),
        );

    Widget _deleteArticle() => IconButton(
        icon: Icon(Icons.delete_outline,
            color: Colors.black, size: _screenSizeWidth / 15),
        onPressed: () async {
          setState(() => _isLoading = true);

          var resp =
              await _articlesRepository.deleteArticle(widget.articleMap['url']);

          if (resp == Response.success) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => HiddenDrowerMenu()),
                (Route<dynamic> route) => false);
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    _buildPopupDialog('Algo salió mal!', false));
          }

          setState(() => _isLoading = false);
        });

    Widget _returnArticle() => Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: Row(
              children: [
                Icon(
                  Icons.keyboard_return_sharp,
                  color: Colors.black,
                  size: _screenSizeWidth / 15,
                ),
                Text('Desistir',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: _fontScaling / 0.065,
                    )),
              ],
            ),
            onTap: () async {
              setState(() => _isLoading = true);

              final article = AcquireArticleModel(
                  url: widget.articleMap['url'],
                  description: widget.articleMap['description'],
                  articleName: widget.articleMap['articleName'],
                  contactUId: widget.articleMap['contactUId'],
                  uId: widget.articleMap['contactUId']);

              final resp = await _articlesRepository.returnArticle(
                  article, widget.articleMap['url']);

              if (resp == Response.success) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => HiddenDrowerMenu()),
                    (Route<dynamic> route) => false);
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _buildPopupDialog('Algo salió mal!', false));
              }

              setState(() => _isLoading = false);
            },
          ),
        );

    /**
     *
     */
    return Container(
      color: Colors.white,
      child: SafeArea(
          bottom: false,
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Scaffold(
                  appBar: AppBar(
                      elevation: 0.0,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      leading: IconButton(
                          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      actions: [
                        widget.isPublished ? _deleteArticle() : _returnArticle()
                      ]),
                  body: SingleChildScrollView(
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: _screenSizeWidth / 20),
                        child: Container(
                            child: Column(children: [
                          _titleText(),
                          SizedBox(height: _screenSizeWidth / 13),
                          _image(),
                          SizedBox(height: _screenSizeWidth / 13),
                          _description(),
                          SizedBox(height: _screenSizeWidth / 13),
                          _contact(),
                          SizedBox(height: _screenSizeWidth / 9),
                        ])),
                      )
                    ]),
                  ))),
    );
  }
}
