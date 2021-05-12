import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

import '../pages/home/homePage.dart';
import '../pages/profile/profilePage.dart';

class HiddenDrowerMenu extends StatefulWidget {
  final String uId;

  const HiddenDrowerMenu({Key key, this.uId}) : super(key: key);

  @override
  _HiddenDrowerMenuState createState() => _HiddenDrowerMenuState();
}

class _HiddenDrowerMenuState extends State<HiddenDrowerMenu> {
  List<ScreenHiddenDrawer> items = List();

  @override
  void initState() {
    super.initState();

    items.add(ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Artículos disponibles',
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18.0),
          colorLineSelected: Color.fromRGBO(153, 148, 250, 1),
        ),
        HomePage()));

    items.add(ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Mi perfil',
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18.0),
          colorLineSelected: Color.fromRGBO(153, 148, 250, 1),
        ),
        ProfilePage(uId: widget.uId)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: HiddenDrawerMenu(
          backgroundColorMenu: Theme.of(context).secondaryHeaderColor,
          backgroundColorAppBar: Theme.of(context).scaffoldBackgroundColor,
          screens: items,
          //    typeOpen: TypeOpen.FROM_RIGHT,
          //    enableScaleAnimin: true,
          //    enableCornerAnimin: true,
          slidePercent: 50.0,
          verticalScalePercent: 90.0,
          contentCornerRadius: 30.0,
          elevationAppBar: 0.0,
          leadingAppBar:
              Icon(Icons.menu, color: Theme.of(context).secondaryHeaderColor),
          // iconMenuAppBar: Icon(Icons.menu),
          //    backgroundContent: DecorationImage((image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
          //    whithAutoTittleName: true,
          //    styleAutoTittleName: TextStyle(color: Colors.red),
          //    actionsAppBar: <Widget>[],
          //    backgroundColorContent: Colors.blue,
          //    tittleAppBar: Center(child: Icon(Icons.ac_unit),),
          // enableShadowItensMenu: true,
        ),
      ),
    );
  }
}
