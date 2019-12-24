import 'package:basic/screens/landing.screen.dart';
import 'package:basic/screens/settings.screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              AppBar(
                title: Text('Basic'),
                automaticallyImplyLeading: false,
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(LandingScreen.routeName);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(SettingsScreen.routeName);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
