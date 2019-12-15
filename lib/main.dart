import 'package:flutter/material.dart';

import './screens/sign_up.screen.dart';
import './screens/settings.screen.dart';
import './screens/landing.screen.dart';
import './screens/sign_in.screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: SignInScreen(),
      routes: {
        SettingsScreen.routeName: (ctx) => SettingsScreen(),
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
        SignInScreen.routeName: (ctx) => SignInScreen(),
      },
    );
  }
}
