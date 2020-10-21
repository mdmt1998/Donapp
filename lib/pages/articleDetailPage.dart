import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../widgets/buttonWidget.dart';

class ArticleDetailPage extends StatefulWidget {
  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  PageController _pageController;

  List<String> images;

  _cardPictureSlider(int index) => AnimatedBuilder(
        animation: _pageController,
        builder: (BuildContext context, Widget widget) {
          double value = 1;
          if (_pageController.position.haveDimensions) {
            value = _pageController.page - index;
            value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
          }
          return Center(
              child: SizedBox(
                  height: Curves.easeInOut.transform(value) * 270.0,
                  width: Curves.easeInOut.transform(value) * 400.0,
                  child: Card(
                      elevation: 3,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(images[index])))));
        },
      );

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.25);

    images = [
      'https://www.flaticon.es/premium-icon/icons/svg/657/657563.svg',
      'https://www.flaticon.es/premium-icon/icons/svg/657/657361.svg',
      'https://www.flaticon.es/premium-icon/icons/svg/657/657260.svg',
      'https://www.flaticon.es/premium-icon/icons/svg/657/657563.svg',
      'https://www.flaticon.es/premium-icon/icons/svg/657/657361.svg',
      'https://www.flaticon.es/premium-icon/icons/svg/657/657260.svg',
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screenSizeWidth = MediaQuery.of(context).size.width;
    final _fontScaling = MediaQuery.of(context).textScaleFactor;

    Widget _principalPictureContainer() => Container(
          height: _screenSizeWidth / 2,
          width: _screenSizeWidth / 1.2,
          child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(_screenSizeWidth / 20))),
              child: Stack(alignment: Alignment.center, children: <Widget>[
                Center(
                  child: Container(
                      height: _screenSizeWidth / 15,
                      width: _screenSizeWidth / 15,
                      child: CircularProgressIndicator(strokeWidth: 3)),
                ),
                Container(
                    width: _screenSizeWidth,
                    height: _screenSizeWidth / 2,
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image:
                          'https://billmes.com/706-large_default/silla-de-ruedas-standard.jpg',
                      fit: BoxFit.scaleDown,
                      placeholderCacheWidth: 100,
                      alignment: Alignment.topCenter,
                    ))
              ])),
        );

    Widget _picturesCarousel() => Container(
          // padding: EdgeInsets.only(left: _screenSizeWidth / 20),
          height: _screenSizeWidth / 6,
          child: PageView.builder(
            controller: _pageController,
            physics: BouncingScrollPhysics(),
            itemBuilder: (_, int index) => _cardPictureSlider(index),
            itemCount: images.length,
          ),
        );

    Widget _descriptionContainer() => Container(
          height: _screenSizeWidth / 2,
          width: _screenSizeWidth / 1.2,
          child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(_screenSizeWidth / 8),
                      bottomLeft: Radius.circular(_screenSizeWidth / 8))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Nashville armchair',
                        style: TextStyle(
                            fontSize: _fontScaling / 0.05,
                            color: Theme.of(context).primaryColor)),
                    Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make ',
                        textAlign: TextAlign.center)
                  ])),
        );

    Widget _contactButton() => ButtonWidget(
          buttonText: 'Contacto',
          elevation: 5,
          onPressed: () {},
        );

    /**
     * 
     */
    return Container(
      color: Colors.white,
      child: SafeArea(
          bottom: false,
          child: Scaffold(
              body: SingleChildScrollView(
            child: Column(children: [
              Row(children: [
                Padding(
                    padding: EdgeInsets.only(
                        left: _screenSizeWidth / 60,
                        top: _screenSizeWidth / 50),
                    child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        }))
              ]),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: _screenSizeWidth / 20),
                child: Container(
                    child: Column(children: [
                  SizedBox(height: _screenSizeWidth / 20),
                  _principalPictureContainer(),
                  SizedBox(height: _screenSizeWidth / 13),
                  _picturesCarousel(),
                  SizedBox(height: _screenSizeWidth / 9),
                  _descriptionContainer(),
                  SizedBox(height: _screenSizeWidth / 9),
                  _contactButton(),
                  SizedBox(height: _screenSizeWidth / 9),
                ])),
              )
            ]),
          ))),
    );
  }
}
