import 'dart:typed_data';

import '../stores/folder.store.dart';
import '../widgets/custom_alert_dialog.widget.dart';
import '../widgets/foldere.widget.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';

import '../widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:scanny/scanny.dart';

class LandingScreen extends StatefulWidget {
  static const routeName = "landing-screen";

  @override
  _LandingScreenState createState() => _LandingScreenState(new Scanny());
}

class _LandingScreenState extends State<LandingScreen> {
  //Uint8List _imageBytes;
  final Scanny scanny;
  bool _blackVisible = false;

  _LandingScreenState(this.scanny);

  @override
  void initState() {
    super.initState();

    //ask permissions
    //askPermissions();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadFolders();
  }

  void loadFolders() {
    final folderStore = Provider.of<FolderStore>(context);
    folderStore.fetchFolders();
  }

  Future<void> askPermissions() async {
    scanny.askPermissions;
  }

  Future<void> scanDocument() async {
    try {
      _blackVisible = true;
      //ask permissions if permissions are not granted yet
      await askPermissions();
      //call the scanner
      scanny.callScanner;
      //listen to the results of activity
      scanny.getImageBytes.listen((imageBytes) {
        //setState(() {
        //_imageBytes = imageBytes;
        //if (_imageBytes != null) {
        // we need to change this so that white screen is not shown while saving the folder.
        _createFolderAndSaveImage(imageBytes);
        //}
        // });
      });
      // save image in a folder

    } catch (error) {
      //print(error);
      _showAlert(title: Constants.ERROR_OCCURED, content: error);
    }
  }

  void _createFolderAndSaveImage(Uint8List imageBytes) {
    FolderStore().createFolderAndSaveImage(imageBytes).then((result) {
      if (result == Constants.SUCCESS) {
        _showAlert(
            title: Constants.SUCCESS,
            content: Constants.SUCCESS_MESSAGE_IMAGE,
            onPressed: () {
              setState(() {
                _blackVisible = false;
              });
            });
        loadFolders();
      }
    });
  }

  void _showAlert({String title, String content, Function onPressed}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          content: content,
          title: title,
          onPressed: onPressed,
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
      body: Stack(
        children: <Widget>[
          FolderWidget(),
          Offstage(
            offstage: !_blackVisible,
            child: GestureDetector(
              onTap: () {},
              child: AnimatedOpacity(
                opacity: _blackVisible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 400),
                curve: Curves.ease,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scanDocument,
        child: Icon(Icons.camera_enhance),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
