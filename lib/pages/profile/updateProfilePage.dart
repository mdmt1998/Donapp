import 'package:donapp/widgets/hiddenDrawerMenu.dart';
import 'package:flutter/material.dart';

import '../../repositories/profile/profileRepository.dart';
import '../../widgets/textFormFieldWidget.dart';
import '../../models/auth/userDataModel.dart';
import '../../widgets/buttonWidget.dart';

class UpdateProfilePage extends StatefulWidget {
  final UserData userData;
  final String nodeValue;

  const UpdateProfilePage({Key key, this.userData, this.nodeValue})
      : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  ProfileRepository _profileRepository = ProfileRepository();

  RegExp _regex;
  Pattern _pattern;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _addressController;
  TextEditingController _phoneController;
  TextEditingController _nameController;
  TextEditingController _cityController;

  bool _isloading = false;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController(text: widget.userData.email);
    _passwordController = TextEditingController(text: widget.userData.password);
    _addressController = TextEditingController(text: widget.userData.address);
    _phoneController =
        TextEditingController(text: widget.userData.phoneNumber.toString());
    _nameController = TextEditingController(text: widget.userData.name);
    _cityController = TextEditingController(text: widget.userData.city);
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
            'Actualizar perfil',
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
              // validator: _validateInputs,
            ),
            SizedBox(height: _screenSizeWidth / 20),
            // TextFormFieldWidget(
            //   hintText: 'correo@correo.com',
            //   controller: _emailController,
            //   textInputType: TextInputType.emailAddress,
            //   autoValidateMode: AutovalidateMode.onUserInteraction,
            //   validator: _validateEmail,
            // ),
            // SizedBox(height: _screenSizeWidth / 20),
            // TextFormFieldWidget(
            //   hintText: 'Contraseña',
            //   controller: _passwordController,
            //   textInputType: TextInputType.text,
            //   autoValidateMode: AutovalidateMode.onUserInteraction,
            //   validator: _validatePassword,
            // ),
            // SizedBox(height: _screenSizeWidth / 20),
            TextFormFieldWidget(
              hintText: 'Ciudad',
              controller: _cityController,
              textInputType: TextInputType.text,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              // validator: _validateInputs,
            ),
            SizedBox(height: _screenSizeWidth / 20),
            TextFormFieldWidget(
              hintText: 'Dirección',
              controller: _addressController,
              textInputType: TextInputType.text,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              // validator: _validateInputs,
            ),
            SizedBox(height: _screenSizeWidth / 20),
            TextFormFieldWidget(
              hintText: 'Número telefónico',
              controller: _phoneController,
              textInputType: TextInputType.phone,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              // validator: _validateInputs,
            )
          ]),
        );

    Widget _registerButton() => ButtonWidget(
          buttonText: 'Actualizar',
          elevation: 3.0,
          height: _screenSizeWidth / 11,
          width: _screenSizeWidth / 2.5,
          onPressed: () async {
            setState(() => _isloading = true);

            // if (!_formKey.currentState.validate()) return;

            try {
              var userData = UserData(
                  uId: widget.userData.uId,
                  email: _emailController.text,
                  password: _passwordController.text,
                  name: _nameController.text,
                  address: _addressController.text,
                  phoneNumber: int.tryParse(_phoneController.text),
                  city: _cityController.text);

              await _profileRepository.updateUserData(
                  userData, widget.nodeValue);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HiddenDrowerMenu(uId: widget.userData.uId)));
            } catch (e) {
              print(e.toString());
            }
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
