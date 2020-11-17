import 'package:flutter/material.dart';

class AcquireAriclePage extends StatefulWidget {
  @override
  _AcquireAriclePageState createState() => _AcquireAriclePageState();
}

class _AcquireAriclePageState extends State<AcquireAriclePage> {
  @override
  Widget build(BuildContext context) {
    final _screenSizeWidth = MediaQuery.of(context).size.width;
    final _fontScaling = MediaQuery.of(context).textScaleFactor;

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
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }))
                ]),
                // _titleText(),
                SizedBox(height: _screenSizeWidth / 20),
                // _registerFields(),
                SizedBox(height: _screenSizeWidth / 10),
                // _registerButton(),
                SizedBox(height: _screenSizeWidth / 5),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
