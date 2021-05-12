import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../widgets/buttonWidget.dart';
import '../../../widgets/hiddenDrawerMenu.dart';

class SuccessfullyAcquirePage extends StatefulWidget {
  @override
  _SuccessfullyAcquirePageState createState() =>
      _SuccessfullyAcquirePageState();
}

class _SuccessfullyAcquirePageState extends State<SuccessfullyAcquirePage> {
  bool isExpanding = true;

  @override
  Widget build(BuildContext context) {
    final _screenSizeWidth = MediaQuery.of(context).size.width;
    final _fontScaling = MediaQuery.of(context).textScaleFactor;

    Widget _titleText() => Center(
          child: Container(
            alignment: Alignment.center,
            child: Text(
                '¡Felicitaciones, adquiriste un articulo, debes acordar con el donante!',
                style: TextStyle(fontSize: _fontScaling / 0.065),
                textAlign: TextAlign.center),
          ),
        );

    Widget _contact() => Card(
          color: Colors.white,
          elevation: 4.0,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Contacto',
                        style: TextStyle(
                            fontSize: _fontScaling / 0.04,
                            color: Theme.of(context).primaryColor)),
                    SizedBox(height: _screenSizeWidth / 15),
                    Text('Nombre Apellido',
                        style: TextStyle(fontSize: _fontScaling / 0.065)),
                    SizedBox(height: _screenSizeWidth / 15),
                    Text('Dirección',
                        style: TextStyle(fontSize: _fontScaling / 0.065)),
                    SizedBox(height: _screenSizeWidth / 65),
                    Text('Ciudad',
                        style: TextStyle(fontSize: _fontScaling / 0.065)),
                    SizedBox(height: _screenSizeWidth / 15),
                    Text('correo@correo.com',
                        style: TextStyle(fontSize: _fontScaling / 0.065)),
                    SizedBox(height: _screenSizeWidth / 65),
                    Text('000 000 0000',
                        style: TextStyle(fontSize: _fontScaling / 0.065)),
                    SizedBox(height: _screenSizeWidth / 15),
                    Text('idAdq.: 1234',
                        style: TextStyle(fontSize: _fontScaling / 0.08)),
                  ],
                )),
          ),
        );

    Widget _finishButton() => ButtonWidget(
          buttonText: 'Finalizar',
          elevation: 5.0,
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => HiddenDrowerMenu()),
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
            padding: EdgeInsets.symmetric(
              horizontal: _screenSizeWidth / 20,
            ),
            child: SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(height: _screenSizeWidth / 5),
                SvgPicture.asset('assets/newProduct.svg',
                    fit: BoxFit.cover, height: _screenSizeWidth / 2.2),
                SizedBox(height: _screenSizeWidth / 10),
                _titleText(),
                SizedBox(height: _screenSizeWidth / 8),
                _contact(),
                SizedBox(height: _screenSizeWidth / 5),
                _finishButton(),
                SizedBox(height: _screenSizeWidth / 5),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
