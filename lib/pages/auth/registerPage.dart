import 'package:flutter/material.dart';

import '../../widgets/buttonWidget.dart';
import '../../widgets/hiddenDrawerMenu.dart';
import '../../widgets/textFormFieldWidget.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _addressController;
  TextEditingController _phoneController;
  TextEditingController _nameController;
  TextEditingController _cityController;

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
          child: Column(
            children: [
              TextFormFieldWidget(
                hintText: 'Nombre completo',
                controller: _nameController,
                textInputType: TextInputType.text,
              ),
              SizedBox(height: _screenSizeWidth / 20),
              TextFormFieldWidget(
                hintText: 'correo@correo.com',
                controller: _emailController,
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: _screenSizeWidth / 20),
              TextFormFieldWidget(
                  hintText: 'Contraseña',
                  controller: _passwordController,
                  textInputType: TextInputType.text),
              SizedBox(height: _screenSizeWidth / 20),
              TextFormFieldWidget(
                hintText: 'Ciudad',
                controller: _cityController,
                textInputType: TextInputType.text,
              ),
              SizedBox(height: _screenSizeWidth / 20),
              TextFormFieldWidget(
                hintText: 'Dirección',
                controller: _addressController,
                textInputType: TextInputType.text,
              ),
              SizedBox(height: _screenSizeWidth / 20),
              TextFormFieldWidget(
                  hintText: 'Número telefónico',
                  controller: _phoneController,
                  textInputType: TextInputType.phone)
            ],
          ),
        );

    Widget _registerButton() => ButtonWidget(
          buttonText: 'Crear cuenta',
          elevation: 3,
          height: _screenSizeWidth / 11,
          width: _screenSizeWidth / 2.5,
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
          body: Padding(
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
