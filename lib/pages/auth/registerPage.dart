import 'package:flutter/material.dart';

import '../../repositories/auth/authRepository.dart';
import '../../widgets/textFormFieldWidget.dart';
import '../../models/auth/userDataModel.dart';
import '../../widgets/hiddenDrawerMenu.dart';
import '../../widgets/buttonWidget.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  AuthRepository _authService = AuthRepository();

  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _addressController;
  TextEditingController _phoneController;
  TextEditingController _nameController;
  TextEditingController _cityController;

  RegExp _regex;
  Pattern _pattern;

  bool _isloading = false;

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
    _addressController = TextEditingController();
    _phoneController = TextEditingController();
    _nameController = TextEditingController();
    _cityController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
              hintText: 'Contraseña',
              controller: _passwordController,
              textInputType: TextInputType.text,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: _validatePassword,
            ),
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

    Widget _registerButton() => ButtonWidget(
          buttonText: 'Crear cuenta',
          elevation: 3,
          height: _screenSizeWidth / 11,
          width: _screenSizeWidth / 2.5,
          onPressed: () async {
            if (!_formKey.currentState.validate()) return;

            try {
              setState(() => _isloading = true);

              var result = await _authService.registerEmailAndPassword(
                  _emailController.text, _passwordController.text);

              print(result);

              if (result == null) {
                print('error');
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

                await _authService.registerUserData(userData
                    // result.uid.toString(),
                    // _emailController.text,
                    // _passwordController.text,
                    // _nameController.text,
                    // _addressController.text,
                    // int.tryParse(_phoneController.text),
                    // _cityController.text
                    );

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HiddenDrowerMenu(uId: result?.uid.toString())));
              }

              setState(() => _isloading = false);
            } catch (e) {
              print(e.toString());
            }
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
