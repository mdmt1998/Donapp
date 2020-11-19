import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'auth/loginPage.dart';

class ProfilePage extends StatelessWidget {
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
            Text('Nombre Apellido'),
            SizedBox(height: _screenSizeWidth / 40),
            Text('Direccion'),
            SizedBox(height: _screenSizeWidth / 40),
            Text('Ciudad')
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
            print('hola');
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
              Text('Articulos adquiridos')
            ],
          ),
          onTap: () {
            print('hola');
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
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => LoginPage()),
                (Route<dynamic> route) => false);
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
            body: Padding(
          padding: EdgeInsets.symmetric(horizontal: _screenSizeWidth / 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _titleText(),
            SizedBox(height: _screenSizeWidth / 10),
            _userInformation(),
            SizedBox(height: _screenSizeWidth / 10),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                    height: _screenSizeWidth / 700.0, color: Colors.grey[400])),
            SizedBox(height: _screenSizeWidth / 10),
            _userPublishedArticles(),
            SizedBox(height: _screenSizeWidth / 20),
            _acquireArticles(),
            SizedBox(height: _screenSizeWidth / 3),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                    height: _screenSizeWidth / 700.0, color: Colors.grey[400])),
            SizedBox(height: _screenSizeWidth / 20),
            _logout()
          ]),
        )),
      ),
    );
  }
}
