import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DonorContactPage extends StatefulWidget {
  @override
  _DonorContactPageState createState() => _DonorContactPageState();
}

class _DonorContactPageState extends State<DonorContactPage> {
  @override
  Widget build(BuildContext context) {
    final _screenSizeWidth = MediaQuery.of(context).size.width;
    final _fontScaling = MediaQuery.of(context).textScaleFactor;

    Widget _titleText() => Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Datos de contacto',
            style: TextStyle(fontSize: _fontScaling / 0.038),
          ),
        );

    Widget _conatactData() => Padding(
          padding: const EdgeInsets.all(42.0),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nombre Apellido',
                    style: TextStyle(fontSize: _fontScaling / 0.04)),
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
                    style: TextStyle(fontSize: _fontScaling / 0.065))
              ],
            ),
          ),
        );

    /**
     * 
     */
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _screenSizeWidth / 20,
            ),
            child: SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(height: _screenSizeWidth / 20),
                _titleText(),
                SizedBox(height: _screenSizeWidth / 5),
                SvgPicture.asset('assets/contact.svg',
                    fit: BoxFit.cover, height: _screenSizeWidth / 2),
                _conatactData(),
                SizedBox(height: _screenSizeWidth / 15),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
