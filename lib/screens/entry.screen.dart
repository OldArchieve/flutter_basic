import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../stores/user.store.dart';
import '../screens/auth.screens.dart';
import '../screens/landing.screen.dart';

class EntryScreen extends StatefulWidget {
  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  bool _isLoggedIn = false;
  bool _isLoading = true;

  @override
  void initState() {
    () async {
      await new Future.delayed(Duration.zero, () {
        tryAutoLogin();
      });
    }();

    super.initState();
  }

  void tryAutoLogin() async {
    final usersStore = Provider.of<UsersStore>(context);
    await usersStore.autoLogin();
    setState(() {
      _isLoggedIn = usersStore.isUserLoggedIn;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _isLoading
          ? Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : _isLoggedIn ? LandingScreen() : AuthScreens(),
    );
  }
}
