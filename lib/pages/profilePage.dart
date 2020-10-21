import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _screenSizeWidth = MediaQuery.of(context).size.width;
    final _fontScaling = MediaQuery.of(context).textScaleFactor;

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                ClipOval(
                  child: Icon(Icons.person_pin,
                      size: _screenSizeWidth / 5,
                      color: Theme.of(context).accentColor),
                  // child: Image.network('https://via.placeholder.com/150',
                  //     height: _screenSizeWidth / 5,
                  //     width: _screenSizeWidth / 5,
                  //     fit: BoxFit.cover),
                ),
                SizedBox(width: _screenSizeWidth / 20),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Nombre Apellido'),
                  SizedBox(height: _screenSizeWidth / 40),
                  Text('Direccion'),
                  SizedBox(height: _screenSizeWidth / 40),
                  Text('Ciudad')
                ]),
              ]),
              SizedBox(height: _screenSizeWidth / 8),
              GestureDetector(
                child: Row(
                  children: [
                    Icon(
                      Icons.article,
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(width: _screenSizeWidth / 20),
                    Text('Artículos publicados')
                  ],
                ),
                onTap: () {
                  print('hola');
                },
              ),
            ],
          ),
        )),
      ),
    );
  }
}
