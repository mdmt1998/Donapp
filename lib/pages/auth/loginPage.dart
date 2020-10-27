import 'package:flutter/material.dart';

import '../../widgets/buttonWidget.dart';
import '../../widgets/hiddenDrawerMenu.dart';
import '../../widgets/textFormFieldWidget.dart';
import 'registerPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController;
  TextEditingController _passwordController;

  bool autoValidate = false;

  // _validateInputs() {
  //   final form = _formKey.currentState;
  //   if (form.validate()) {
  //     form.save();
  //   } else {
  //     setState(() {
  //       autoValidate = true;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screenSizeWidth = MediaQuery.of(context).size.width;
    final _fontScaling = MediaQuery.of(context).textScaleFactor;

    Widget _titleText() => Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Bienvenido',
            style: TextStyle(fontSize: _fontScaling / 0.038),
          ),
        );

    Widget _loginFields() => Form(
          key: _formKey,
          child: Column(children: [
            TextFormFieldWidget(
              hintText: 'correo@correo.com',
              controller: _emailController,
              autoValidateMode: AutovalidateMode.always,
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(height: _screenSizeWidth / 20),
            TextFormFieldWidget(
                hintText: 'Contraseña',
                controller: _passwordController,
                textInputType: TextInputType.text),
          ]),
        );

    Widget _createAccount() => Container(
          alignment: Alignment.centerRight,
          child: FlatButton(
            child: Text('Crear cuenta'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterPage()));
            },
          ),
        );

    Widget _loginButton() => ButtonWidget(
          buttonText: 'Iniciar sesión',
          height: _screenSizeWidth / 11,
          width: _screenSizeWidth / 2.5,
          elevation: 2,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HiddenDrowerMenu()));
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
          backgroundColor: Colors.black87,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: _screenSizeWidth / 1.13,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(_screenSizeWidth / 10),
                        topLeft: Radius.circular(_screenSizeWidth / 10))),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: _screenSizeWidth / 15,
                      top: _screenSizeWidth / 15,
                      right: _screenSizeWidth / 15),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          _titleText(),
                          SizedBox(height: _screenSizeWidth / 15),
                          _loginFields(),
                          _createAccount(),
                          SizedBox(height: _screenSizeWidth / 50),
                          _loginButton(),
                          SizedBox(height: _screenSizeWidth / 900),
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
