import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

import '../pages/about/about.dart';
import '../pages/home/homePage.dart';
import '../pages/profile/profilePage.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
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
        ProfilePage()));

    items.add(ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Acerca de',
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18.0),
          colorLineSelected: Color.fromRGBO(153, 148, 250, 1),
        ),
        About()));
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
            slidePercent: 50.0,
            verticalScalePercent: 90.0,
            contentCornerRadius: 30.0,
            elevationAppBar: 0.0,
            styleAutoTittleName:
                TextStyle(color: Theme.of(context).primaryColor),
            leadingAppBar: Icon(Icons.menu,
                color: Theme.of(context).secondaryHeaderColor)),
      ),
    );
  }
}
