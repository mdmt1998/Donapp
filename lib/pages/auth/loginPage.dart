import 'package:flutter/material.dart';

import '../../repositories/auth/authRepository.dart';
import '../../widgets/buttonWidget.dart';
import '../../widgets/drawerMenu.dart';
import '../../widgets/textFormFieldWidget.dart';
import 'registerPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  AuthRepository _authService = AuthRepository();

  TextEditingController _emailController;
  TextEditingController _passwordController;

  RegExp _regex;
  Pattern _pattern;

  bool _isLoading = false;
  bool _showPassword = false;

  String _validateEmail(value) {
    _pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    _regex = RegExp(_pattern);
    if (value.isEmpty) {
      return 'El campo correo electrónico es obligatorio';
    } else {
      if (!_regex.hasMatch(value)) {
        return 'Debe ser un correo electrónico válido';
      } else {
        return null;
      }
    }
  }

  String _validatePassword(value) {
    _pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[.!@#\$&*~]).{8,}$';
    _regex = RegExp(_pattern);
    if (value.isEmpty) {
      return 'El campo contraseña es obligatorio';
    } else {
      if (!_regex.hasMatch(value)) {
        return 'El formato del campo contraseña no es válido';
      } else {
        return null;
      }
    }
  }

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

    Widget _buildPopupDialog() => AlertDialog(
          title: Text('Iniciar sesión'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Por favor, revise su usuario o contraseña'),
            ],
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              textColor: Theme.of(context).primaryColor,
              child: Text('Ok'),
            ),
          ],
        );

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
                autoValidateMode: AutovalidateMode.onUserInteraction,
                textInputType: TextInputType.emailAddress,
                validator: _validateEmail),
            SizedBox(height: _screenSizeWidth / 20),
            TextFormFieldWidget(
                hintText: !_showPassword ? 'Contraseña' : '********',
                controller: _passwordController,
                textInputType: TextInputType.text,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: _validatePassword,
                obscureText: !_showPassword,
                suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() => _showPassword = !_showPassword);
                    },
                    child: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                        size: _screenSizeWidth / 20))),
          ]),
        );

    Widget _createAccount() => Container(
          alignment: Alignment.centerRight,
          child: RaisedButton(
            elevation: 0.0,
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
          elevation: 2.0,
          onPressed: () async {
            setState(() => _isLoading = true);

            // if (!_formKey.currentState.validate()) return;

            try {
              var result = await _authService.signIn(
                  _emailController.text, _passwordController.text);
                  
              if (result == null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => _buildPopupDialog());
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DrawerMenu()));
              }
            } catch (_) {}

            setState(() => _isLoading = false);
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
          body: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: _screenSizeWidth / 8),
                    Image(
                        image: AssetImage('assets/iconLauncher.png'),
                        height: _screenSizeWidth / 2),
                    SizedBox(height: _screenSizeWidth / 7),
                    Container(
                        height: _screenSizeWidth / 1.13,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight:
                                    Radius.circular(_screenSizeWidth / 10),
                                topLeft:
                                    Radius.circular(_screenSizeWidth / 10))),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: _screenSizeWidth / 15,
                              top: _screenSizeWidth / 15,
                              right: _screenSizeWidth / 15),
                          child: Column(
                            children: [
                              _titleText(),
                              SizedBox(height: _screenSizeWidth / 15),
                              _loginFields(),
                              _createAccount(),
                              SizedBox(height: _screenSizeWidth / 50),
                              _loginButton(),
                              SizedBox(height: _screenSizeWidth / 20),
                            ],
                          ),
                        )),
                  ],
                ),
        ),
      ),
    );
  }
}
