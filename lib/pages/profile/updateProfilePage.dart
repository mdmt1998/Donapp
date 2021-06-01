import 'package:flutter/material.dart';

import '../../repositories/globals/constants/constants.dart';
import '../../repositories/profile/profileRepository.dart';
import '../../widgets/textFormFieldWidget.dart';
import '../../models/auth/userDataModel.dart';
import '../../widgets/hiddenDrawerMenu.dart';
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

    Widget _buildPopupDialog(String body, bool success) => AlertDialog(
          title: Text('Actualizar perfil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(body),
            ],
          ),
          actions: [
            FlatButton(
              child: Text('Ok'),
              textColor: Theme.of(context).primaryColor,
              onPressed: () {
                if (success) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => HiddenDrowerMenu()),
                      (Route<dynamic> route) => false);
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );

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
            ),
            SizedBox(height: _screenSizeWidth / 20),
            TextFormFieldWidget(
              hintText: 'Ciudad',
              controller: _cityController,
              textInputType: TextInputType.text,
              autoValidateMode: AutovalidateMode.onUserInteraction,
            ),
            SizedBox(height: _screenSizeWidth / 20),
            TextFormFieldWidget(
              hintText: 'Dirección',
              controller: _addressController,
              textInputType: TextInputType.text,
              autoValidateMode: AutovalidateMode.onUserInteraction,
            ),
            SizedBox(height: _screenSizeWidth / 20),
            TextFormFieldWidget(
              hintText: 'Número telefónico',
              controller: _phoneController,
              textInputType: TextInputType.phone,
              autoValidateMode: AutovalidateMode.onUserInteraction,
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

            var userData = UserData(
                uId: widget.userData.uId,
                email: _emailController.text,
                password: _passwordController.text,
                name: _nameController.text,
                address: _addressController.text,
                phoneNumber: int.tryParse(_phoneController.text),
                city: _cityController.text);

            var resp = await _profileRepository.updateUserData(
                userData, widget.nodeValue);

            if (resp == Response.success) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialog(
                      'Se ha actualizado el perfil correctamente', true));
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialog(
                      'Algo salió mal!, por favor, revise los campos', false));
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
