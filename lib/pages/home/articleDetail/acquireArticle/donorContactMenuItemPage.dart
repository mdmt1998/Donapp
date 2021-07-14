import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../repositories/profile/profileRepository.dart';
import '../../../../models/auth/userDataModel.dart';

class DonorContactPage extends StatefulWidget {
  final String contactUId;

  const DonorContactPage({Key key, @required this.contactUId})
      : super(key: key);

  @override
  _DonorContactPageState createState() => _DonorContactPageState();
}

class _DonorContactPageState extends State<DonorContactPage> {
  ProfileRepository _profileRepository = ProfileRepository();
  UserData _contactData = UserData();

  bool _isLoading = false;

  _getContactInformation() async {
    setState(() => _isLoading = true);

    await _profileRepository
        .getUserData(widget.contactUId)
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

    Widget _titleText() => Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Datos de contacto',
            style: TextStyle(fontSize: _fontScaling / 0.038),
          ),
        );

    Widget _contactDataColumn() => Padding(
          padding: const EdgeInsets.all(42.0),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_contactData?.name,
                    style: TextStyle(fontSize: _fontScaling / 0.04)),
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
            ),
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
                      SizedBox(height: _screenSizeWidth / 20),
                      _titleText(),
                      SizedBox(height: _screenSizeWidth / 5),
                      SvgPicture.asset('assets/contact.svg',
                          fit: BoxFit.cover, height: _screenSizeWidth / 2),
                      _contactDataColumn(),
                      SizedBox(height: _screenSizeWidth / 15),
                    ],
                  )),
                ),
              ),
      ),
    );
  }
}
