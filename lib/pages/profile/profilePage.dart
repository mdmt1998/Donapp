import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../repositories/profile/profileRepository.dart';
import '../../repositories/authRepository.dart';
import '../../models/auth/userDataModel.dart';
import 'articles/articlesPublishedPage.dart';
import 'articles/articlesObtainedPage.dart';
import '../auth/loginPage.dart';

class ProfilePage extends StatefulWidget {
  final String uId;

  const ProfilePage({Key key, @required this.uId}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthRepository _authRepository = AuthRepository();
  ProfileRepository _profileRepository = ProfileRepository();
  UserData _userData = UserData();

  bool _isloading = false;

  _getUserInformation() async {
    setState(() => _isloading = true);

    try {
      await _profileRepository
          .getUserData(widget.uId)
          .then((value) => setState(() => _userData = value));
    } catch (e) {
      print(e.toString());
    }

    setState(() => _isloading = false);
  }

  @override
  void initState() {
    super.initState();
    _getUserInformation();
  }

  @override
  Widget build(BuildContext context) {
    final _screenSizeWidth = MediaQuery.of(context).size.width;
    final _fontScaling = MediaQuery.of(context).textScaleFactor;

    Widget _titleText() => Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Tu perfil',
            style: TextStyle(fontSize: _fontScaling / 0.038),
          ),
        );

    Widget _userInformation() => Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SvgPicture.asset('assets/user.svg',
                fit: BoxFit.cover,
                color: Theme.of(context).accentColor,
                height: _screenSizeWidth / 4.5),
            SizedBox(height: _screenSizeWidth / 20),
            Text(_userData?.name),
            SizedBox(height: _screenSizeWidth / 40),
            Text(_userData?.address),
            SizedBox(height: _screenSizeWidth / 40),
            Text(_userData?.city)
          ]),
        );

    Widget _userPublishedArticles() => GestureDetector(
          child: Row(
            children: [
              Icon(
                Icons.add_shopping_cart,
                color: Theme.of(context).accentColor,
              ),
              SizedBox(width: _screenSizeWidth / 20),
              Text('Artículos publicados')
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArticlesPublishedPage()));
          },
        );

    Widget _acquireArticles() => GestureDetector(
          child: Row(
            children: [
              Icon(
                Icons.accessible_forward,
                color: Theme.of(context).accentColor,
              ),
              SizedBox(width: _screenSizeWidth / 20),
              Text('Artículos adquiridos')
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArticlesObtainedPage()));
          },
        );

    Widget _logout() => GestureDetector(
          child: Row(children: [
            Icon(
              Icons.logout,
              color: Theme.of(context).accentColor,
            ),
            SizedBox(width: _screenSizeWidth / 20),
            Text('Cerrar sesión')
          ]),
          onTap: () async {
            setState(() => _isloading = true);

            await _authRepository.signOut();

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => LoginPage()),
                (Route<dynamic> route) => false);

            setState(() => _isloading = false);
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
            body: _isloading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: _screenSizeWidth / 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _titleText(),
                          SizedBox(height: _screenSizeWidth / 10),
                          _userInformation(),
                          SizedBox(height: _screenSizeWidth / 10),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                  height: _screenSizeWidth / 700.0,
                                  color: Colors.grey[400])),
                          SizedBox(height: _screenSizeWidth / 10),
                          _userPublishedArticles(),
                          SizedBox(height: _screenSizeWidth / 20),
                          _acquireArticles(),
                          SizedBox(height: _screenSizeWidth / 3),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                  height: _screenSizeWidth / 700.0,
                                  color: Colors.grey[400])),
                          SizedBox(height: _screenSizeWidth / 20),
                          _logout()
                        ]),
                  )),
      ),
    );
  }
}
