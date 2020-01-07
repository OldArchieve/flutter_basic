import 'package:basic/constants/constants.dart';
import 'package:basic/stores/folder.store.dart';
import 'package:basic/widgets/custom_alert_dialog.widget.dart';

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
          () async {
            await _saveImage();
          }();
        });
      });
      // save image in a folder

    } catch (error) {
      //print(error);
      _showAlert(title: Constants.ERROR_OCCURED, content: error);
    }
  }

  Future<void> _saveImage() async {
    final result = await FolderStore().createFolderAndSaveImage(_imageBytes);
    if (result == "success") {
      _showAlert(title: "Sucess", content: "Image saved successfully");
    }
  }

  void _showAlert({String title, String content}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          content: content,
          title: title,
          onPressed: () {},
        );
      },
    );
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
