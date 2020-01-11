import 'dart:typed_data';

import 'package:basic/models/model.dart';
import 'package:basic/widgets/custom_floating_button.widget.dart';
import 'package:basic/widgets/custom_off_stage.widget.dart';

import '../constants/constants.dart';
import '../stores/folder.store.dart';
import '../widgets/custom_alert_dialog.widget.dart';
import '../widgets/foldere.widget.dart';
import 'package:provider/provider.dart';

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
    final folderStore = Provider.of<FolderStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Landing",
        ),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: folderStore.fetchFolders(),
        builder: (_, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              {
                _blackVisible = true;
                return CustomOffStageWidget(_blackVisible);
              }
            default:
              if (snapshot.hasError) {
                return CustomAlertDialog(
                  title: Constants.ERROR_OCCURED,
                  content: snapshot.error,
                  onPressed: () {},
                );
              } else {
                final List<Folder> folders = snapshot.data;
                return Stack(
                  children: <Widget>[
                    FolderWidget(folders),
                    CustomOffStageWidget(_blackVisible),
                  ],
                );
              }
          }
        },
      ),
      floatingActionButton: CustomFloatingButton(
        onPressed: scanDocument,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
