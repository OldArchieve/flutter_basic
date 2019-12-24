import 'package:basic/constants/constants.dart';
import 'package:basic/screens/sign_in.screen.dart';
import 'package:basic/screens/sign_up.screen.dart';
import 'package:basic/stores/user.store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreens extends StatefulWidget {
  static const routeName = "auth-screens";

  @override
  _AuthScreensState createState() => _AuthScreensState();
}

class _AuthScreensState extends State<AuthScreens> {
  bool _isLogin = true;

  void changeScreen(String type) {
    if (type == Constants.REGISTER_TYPE) {
      setState(() {
        _isLogin = false;
      });
    }
    if (type == Constants.LOGIN_TYPE) {
      setState(() {
        _isLogin = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLogin ? SignInScreen(changeScreen) : SignUpScreen(changeScreen),
    );
  }
}
