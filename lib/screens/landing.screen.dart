import '../widgets/item.widget.dart';

import '../widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:scanny/scanny.dart';

class LandingScreen extends StatefulWidget {
  static const routeName = "landing-screen";

  @override
  _LandingScreenState createState() => _LandingScreenState(new Scanny());
}

class _LandingScreenState extends State<LandingScreen> {
  dynamic _imageBytes;
  final Scanny scanny;

  _LandingScreenState(this.scanny);

  @override
  void initState() {
    super.initState();

    () async {
      //ask permissions
      //askPermissions();
    }();
  }

  Future<void> askPermissions() async {
    scanny.askPermissions;
  }

  Future<void> scanDocument() async {
    try {
      //ask permissions if permissions are not granted yet
      await askPermissions();
      //call the scanner
      scanny.callScanner;
      //listen to the results of activity
      scanny.getImageBytes.listen((imageBytes) {
        setState(() {
          _imageBytes = imageBytes;
        });
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Landing",
        ),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: ItemWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scanDocument,
        child: Icon(Icons.camera_enhance),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
