import 'package:basic/models/model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './screens/auth.screens.dart';
import './screens/entry.screen.dart';
import './stores/user.store.dart';
import './screens/settings.screen.dart';
import './screens/landing.screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isExisting = await BasicModel().initializeDB();
  if (isExisting) {
    //BasicModel().initializeDB();

  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MultiProvider(
        providers: [
          Provider<UsersStore>(
            create: (_) => UsersStore(),
          ),
        ],
        child: EntryScreen(),
      ),
      routes: {
        SettingsScreen.routeName: (ctx) => SettingsScreen(),
        AuthScreens.routeName: (ctx) => AuthScreens(),
        LandingScreen.routeName: (ctx) => LandingScreen(),
      },
    );
  }
}
