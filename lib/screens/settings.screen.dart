import 'package:basic/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = "/settings.screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text("Settings"),
      ),
    );
  }
}
