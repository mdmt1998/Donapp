import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../repositories/articles/articlesRepository.dart';
import '../../../repositories/globals/constants/constants.dart';
import '../../../widgets/textFormFieldWidget.dart';
import '../../../models/articles/imageModel.dart';
import '../../../widgets/hiddenDrawerMenu.dart';
import '../../../widgets/buttonWidget.dart';

class PublishArticlePage extends StatefulWidget {
  final String uId;

  const PublishArticlePage({Key key, @required this.uId}) : super(key: key);

  @override
  _PublishArticlePageState createState() => _PublishArticlePageState();
}

class _PublishArticlePageState extends State<PublishArticlePage> {
  final _formKey = GlobalKey<FormState>();

  ArticlesRepository _articlesRepository = ArticlesRepository();

  TextEditingController _articleNameController;
  TextEditingController _descriptionController;

  Future<PickedFile> _imagePickedFile;
  File _selectedPicture;

  String _img;

  bool _isloading = false;

  Future _selectImageFromGallery(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();

    try {
      setState(() {
        _imagePickedFile = picker.getImage(source: imageSource);
      });
    } catch (e) {}
  }

  _postArticle() async {
    final file = _selectedPicture;

    var image = ImageModel(
        file: file,
        description: _descriptionController.text,
        articleName: _articleNameController.text);

    return await _articlesRepository.postArticle(image, widget.uId);
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

    Widget _buildPopupDialog(String body, bool success) => AlertDialog(
          title: Text('publicar artículo'),
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
            'Publicar artículo',
            style: TextStyle(fontSize: _fontScaling / 0.04),
          ),
        );

    Widget _registerFields() => Form(
          key: _formKey,
          child: Column(children: [
            TextFormFieldWidget(
              hintText: 'Nombre del artículo',
              controller: _articleNameController,
              textInputType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
            ),
            SizedBox(height: _screenSizeWidth / 20),
            TextFormFieldWidget(
              hintText: 'Descripción',
              controller: _descriptionController,
              maxLines: 3,
              textInputType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
            ),
            SizedBox(height: _screenSizeWidth / 20)
          ]),
        );

    Widget _showImage() => FutureBuilder<PickedFile>(
          future: _imagePickedFile,
          builder: (_, snapshot) {
            if ((snapshot.connectionState == ConnectionState.done) &&
                (snapshot.data.path != null)) {
              _img = snapshot.data.path;
              _selectedPicture = File(snapshot.data.path);
              return Image.file(
                File(snapshot.data.path),
                fit: BoxFit.cover,
              );
            } else if (snapshot.error != null) {
              return Center(
                  child: Text('Error al seleccionar la imagen',
                      textAlign: TextAlign.center));
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
              _selectImageFromGallery(ImageSource.gallery);
            },
            child: Card(elevation: 2.0, child: Center(child: _showImage())),
          ),
        );

    Widget _buttonPublish() => ButtonWidget(
          buttonText: 'Publicar',
          elevation: 3,
          height: _screenSizeWidth / 11,
          width: _screenSizeWidth / 2.5,
          onPressed: () async {
            setState(() => _isloading = true);

            var resp = await _postArticle();

            if (resp == Response.success) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialog(
                      'Se ha publicado el artículo correctamente', true));
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
          child: _isloading
              ? Center(child: CircularProgressIndicator())
              : Scaffold(
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
                        padding: EdgeInsets.symmetric(
                            horizontal: _screenSizeWidth / 20),
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
