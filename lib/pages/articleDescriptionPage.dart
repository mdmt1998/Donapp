import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ArticleDescriptionPage extends StatefulWidget {
  @override
  _ArticleDescriptionPageState createState() => _ArticleDescriptionPageState();
}

class _ArticleDescriptionPageState extends State<ArticleDescriptionPage> {
  @override
  Widget build(BuildContext context) {
    final _screenSizeWidth = MediaQuery.of(context).size.width;
    final _fontScaling = MediaQuery.of(context).textScaleFactor;

    Widget _titleText() => Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Nashville armchair',
            style: TextStyle(fontSize: _fontScaling / 0.04),
          ),
        );

    Widget _image() => FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image:
              'https://billmes.com/706-large_default/silla-de-ruedas-standard.jpg',
          fit: BoxFit.scaleDown,
          placeholderCacheWidth: 100,
          alignment: Alignment.topCenter,
        );

    Widget _descrption() => Center(
          child: Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make'),
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
              body: SingleChildScrollView(
                child: Column(children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: _screenSizeWidth / 20),
                    child: Container(
                        child: Column(children: [
                      _titleText(),
                      SizedBox(height: _screenSizeWidth / 13),
                      _image(),
                      SizedBox(height: _screenSizeWidth / 13),
                      _descrption(),
                      SizedBox(height: _screenSizeWidth / 13),
                      _contact(),
                      SizedBox(height: _screenSizeWidth / 9),
                    ])),
                  )
                ]),
              ))),
    );
  }
}
