import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../repositories/profile/profileRepository.dart';
import '../../../models/auth/userDataModel.dart';

class ArticleDescriptionPage extends StatefulWidget {
  final String uId;
  final Map articleMap;

  const ArticleDescriptionPage(
      {Key key, @required this.uId, @required this.articleMap})
      : super(key: key);

  @override
  _ArticleDescriptionPageState createState() => _ArticleDescriptionPageState();
}

class _ArticleDescriptionPageState extends State<ArticleDescriptionPage> {
  ProfileRepository _profileRepository = ProfileRepository();
  UserData _contactData = UserData();

  bool _isloading = false;

  _getContactInformation() async {
    setState(() => _isloading = true);

    await _profileRepository
        .getUserData(widget.uId)
        .then((value) => setState(() => _contactData = value));

    setState(() => _isloading = false);
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
          // 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make'),
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
                    Text(_contactData.name,
                        style: TextStyle(fontSize: _fontScaling / 0.065)),
                    SizedBox(height: _screenSizeWidth / 15),
                    Text(_contactData.address,
                        style: TextStyle(fontSize: _fontScaling / 0.065)),
                    SizedBox(height: _screenSizeWidth / 65),
                    Text(_contactData.city,
                        style: TextStyle(fontSize: _fontScaling / 0.065)),
                    SizedBox(height: _screenSizeWidth / 15),
                    Text(_contactData.email,
                        style: TextStyle(fontSize: _fontScaling / 0.065)),
                    SizedBox(height: _screenSizeWidth / 65),
                    Text('(+57) ${_contactData.phoneNumber}',
                        style: TextStyle(fontSize: _fontScaling / 0.065)),
                    SizedBox(height: _screenSizeWidth / 15),
                    Text('idReg.: 000', // TODO: Implement transaction id
                        style: TextStyle(fontSize: _fontScaling / 0.08)),
                  ],
                )),
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
