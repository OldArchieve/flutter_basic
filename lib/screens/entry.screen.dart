import 'package:basic/screens/auth.screens.dart';
import 'package:basic/screens/landing.screen.dart';
import 'package:basic/screens/sign_in.screen.dart';
import 'package:basic/screens/sign_up.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../stores/user.store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EntryScreen extends StatefulWidget {
  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    final usersStore = Provider.of<UsersStore>(context);
    return Observer(
      builder: (_con) {
        if (usersStore.isUserLoggedIn) {
          return LandingScreen();
        } else {
          return AuthScreens();
        }
      },
    );
  }
}
