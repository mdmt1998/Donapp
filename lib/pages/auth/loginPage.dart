import 'package:flutter/material.dart';

import '../../widgets/buttonWidget.dart';
import 'registerPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          backgroundColor: Colors.black87,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: _screenSizeWidth / 1.1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(_screenSizeWidth / 10),
                        topLeft: Radius.circular(_screenSizeWidth / 10))),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Row(children: [
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Theme.of(context).primaryColor,
                                  size: _screenSizeWidth / 12,
                                ),
                                onPressed: () {
                                  print('hola');
                                })
                          ]),
                          SizedBox(height: _screenSizeWidth / 15),
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Bienvenido',
                                style:
                                    TextStyle(fontSize: _fontScaling / 0.038),
                              )),
                          SizedBox(height: _screenSizeWidth / 3.7),
                          ButtonWidget(
                            buttonText: 'Iniciar sesión',
                            height: _screenSizeWidth / 11,
                            width: _screenSizeWidth / 2.5,
                            elevation: 2,
                            onPressed: null,
                          ),
                          SizedBox(height: _screenSizeWidth / 100),
                          FlatButton(
                            child: Text('Crear cuenta'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
