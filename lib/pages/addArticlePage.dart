import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/buttonWidget.dart';
import '../widgets/textFormFieldWidget.dart';

class AddArticlePage extends StatefulWidget {
  @override
  _AddArticlePageState createState() => _AddArticlePageState();
}

class _AddArticlePageState extends State<AddArticlePage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _articleNameController;
  TextEditingController _descriptionController;

  Future<PickedFile> _imagePickedFile;
  File _selectedPicture;

  Future _selectImageFromGallery(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();

    try {
      setState(() {
        _imagePickedFile = picker.getImage(source: imageSource);
      });
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    _articleNameController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _articleNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screenSizeWidth = MediaQuery.of(context).size.width;
    final _fontScaling = MediaQuery.of(context).textScaleFactor;

    Widget _titleText() => Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Publicar artículo',
            style: TextStyle(fontSize: _fontScaling / 0.04),
          ),
        );

    Widget _registerFields() => Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormFieldWidget(
                hintText: 'Nombre del artículo',
                controller: _articleNameController,
                textInputType: TextInputType.text,
              ),
              SizedBox(height: _screenSizeWidth / 20),
              TextFormFieldWidget(
                hintText: 'Descripción',
                controller: _descriptionController,
                maxLines: 3,
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: _screenSizeWidth / 20)
            ],
          ),
        );

    Widget _showImage() => FutureBuilder<PickedFile>(
          future: _imagePickedFile,
          builder: (_, snapshot) {
            if ((snapshot.connectionState == ConnectionState.done) &&
                (snapshot.data.path != null)) {
              _selectedPicture = File(snapshot.data.path);
              return Image.file(
                File(snapshot.data.path),
                fit: BoxFit.cover,
              );
            } else if (snapshot.error != null) {
              return Center(
                child: Text('Error al seleccionar la imagen',
                    textAlign: TextAlign.center),
              );
            } else {
              return Text('Presiona para cargar una foto');
            }
          },
        );

    Widget _loadPicture() => Container(
          height: _screenSizeWidth / 4,
          width: _screenSizeWidth,
          child: GestureDetector(
            onTap: () {
              setState(() => _selectImageFromGallery(ImageSource.gallery));
            },
            child: Card(
              elevation: 2.0,
              child: Center(child: _showImage()),
            ),
          ),
        );

    Widget _buttonPublish() => ButtonWidget(
          buttonText: 'Publicar',
          elevation: 3,
          height: _screenSizeWidth / 11,
          width: _screenSizeWidth / 2.5,
          onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => HiddenDrowerMenu()));
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
                      _registerFields(),
                      SizedBox(height: _screenSizeWidth / 20),
                      _loadPicture(),
                      SizedBox(height: _screenSizeWidth / 7),
                      _buttonPublish(),
                      SizedBox(height: _screenSizeWidth / 9),
                    ])),
                  )
                ]),
              ))),
    );
  }
}
