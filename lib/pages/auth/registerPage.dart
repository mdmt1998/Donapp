import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../models/auth/userDataModel.dart';
import '../../repositories/auth/authRepository.dart';
import '../../widgets/buttonWidget.dart';
import '../../widgets/drawerMenu.dart';
import '../../widgets/pdfWidget.dart';
import '../../widgets/textFormFieldWidget.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  AuthRepository _authService = AuthRepository();

  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;
  TextEditingController _addressController;
  TextEditingController _phoneController;
  TextEditingController _nameController;
  TextEditingController _cityController;

  RegExp _regex;
  Pattern _pattern;

  bool _isLoading = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  bool _isChecked = false;

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
        return 'Requiere mínimo 8 caracteres, incluyendo 1 mayúscula,\n1 número y 1 especial';
      } else {
        return null;
      }
    }
  }

  String _validateConfirmPassword(value) {
    if (value.isEmpty) {
      return 'El campo confirmar contraseña es obligatorio';
    } else {
      if (_passwordController.text != _confirmPasswordController.text) {
        return 'La constraseña no coincide';
      } else {
        return null;
      }
    }
  }

  String _validateInputs(value) {
    if (value.isEmpty) {
      return 'El campo es obligatorio';
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _addressController = TextEditingController();
    _phoneController = TextEditingController();
    _nameController = TextEditingController();
    _cityController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _nameController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screenSizeWidth = MediaQuery.of(context).size.width;
    final _fontScaling = MediaQuery.of(context).textScaleFactor;

    Widget _buildPopupDialog(String text) => AlertDialog(
          title: Text('Error al registrarse'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text),
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
            'Crear cuenta',
            style: TextStyle(fontSize: _fontScaling / 0.038),
          ),
        );

    Widget _registerFields() => Form(
          key: _formKey,
          child: Column(children: [
            TextFormFieldWidget(
              hintText: 'Nombre completo',
              controller: _nameController,
              textInputType: TextInputType.text,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: _validateInputs,
            ),
            SizedBox(height: _screenSizeWidth / 20),
            TextFormFieldWidget(
              hintText: 'correo@correo.com',
              controller: _emailController,
              textInputType: TextInputType.emailAddress,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: _validateEmail,
            ),
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
            SizedBox(height: _screenSizeWidth / 20),
            TextFormFieldWidget(
                hintText: !_showConfirmPassword ? 'Contraseña' : '********',
                controller: _confirmPasswordController,
                textInputType: TextInputType.text,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: _validateConfirmPassword,
                obscureText: !_showConfirmPassword,
                suffixIcon: GestureDetector(
                    onTap: () {
                      setState(
                          () => _showConfirmPassword = !_showConfirmPassword);
                    },
                    child: Icon(
                        _showConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: _screenSizeWidth / 20))),
            SizedBox(height: _screenSizeWidth / 20),
            TextFormFieldWidget(
              hintText: 'Ciudad',
              controller: _cityController,
              textInputType: TextInputType.text,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: _validateInputs,
            ),
            SizedBox(height: _screenSizeWidth / 20),
            TextFormFieldWidget(
              hintText: 'Dirección',
              controller: _addressController,
              textInputType: TextInputType.text,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: _validateInputs,
            ),
            SizedBox(height: _screenSizeWidth / 20),
            TextFormFieldWidget(
              hintText: 'Número telefónico',
              controller: _phoneController,
              textInputType: TextInputType.phone,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: _validateInputs,
            )
          ]),
        );

    Widget _checkBoxTyC() => Container(
          width: _screenSizeWidth / 1.2,
          child: Row(children: <Widget>[
            Container(
              height: _screenSizeWidth / 50,
              width: _screenSizeWidth / 30,
              child: Checkbox(
                value: _isChecked,
                onChanged: (bool value) {
                  setState(() => _isChecked = value);
                },
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: _screenSizeWidth / 20),
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'Acepto ',
                    style: TextStyle(
                        color: Colors.grey, fontSize: _screenSizeWidth / 32),
                  ),
                  TextSpan(
                    text: 'términos y condiciones',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blueAccent,
                        fontSize: _screenSizeWidth / 32),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PDFWidget(
                                      title: 'Términos y condiciones',
                                      path: 'assets/docs/termsConditions.pdf',
                                    )));
                      },
                  )
                ])))
          ]),
        );

    Widget _registerButton() => ButtonWidget(
          buttonText: 'Crear cuenta',
          elevation: 3,
          height: _screenSizeWidth / 11,
          width: _screenSizeWidth / 2.5,
          onPressed: () async {
            if (!_isChecked) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialog(
                      'Para continuar debe aceptar términos y condiciones.'));
            }

            if (!_formKey.currentState.validate()) return;

            if (!_isChecked) return;

            setState(() => _isLoading = true);

            var result = await _authService.registerEmailAndPassword(
                _emailController.text, _passwordController.text);

            print(result);

            if (result == null) {
              print('error');

              showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialog(
                      'Por favor, revise los campos requeridos'));
            } else {
              print('CREADA');
              print('${result?.uid}');

              var userData = UserData(
                  uId: result?.uid,
                  email: _emailController.text,
                  password: _passwordController.text,
                  name: _nameController.text,
                  address: _addressController.text,
                  phoneNumber: int.tryParse(_phoneController.text),
                  city: _cityController.text);

              await _authService.registerUserData(userData);

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DrawerMenu()));
            }

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
          body: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: _screenSizeWidth / 20,
                  ),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Row(children: [
                        Padding(
                            padding: EdgeInsets.only(
                                left: _screenSizeWidth / 60,
                                top: _screenSizeWidth / 50),
                            child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }))
                      ]),
                      _titleText(),
                      SizedBox(height: _screenSizeWidth / 20),
                      _registerFields(),
                      SizedBox(height: _screenSizeWidth / 20),
                      _checkBoxTyC(),
                      SizedBox(height: _screenSizeWidth / 10),
                      _registerButton(),
                      SizedBox(height: _screenSizeWidth / 5),
                    ],
                  )),
                ),
        ),
      ),
    );
  }
}
