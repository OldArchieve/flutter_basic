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
  dynamic _imageBytes;
  final Scanny scanny;
  bool _isLoading = false;

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
      //ask permissions if permissions are not granted yet
      await askPermissions();
      //call the scanner
      scanny.callScanner;
      //listen to the results of activity
      scanny.getImageBytes.listen((imageBytes) {
        _isLoading = true;
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
    if (result == Constants.SUCCESS) {
      _showAlert(
          title: Constants.SUCCESS, content: Constants.SUCCESS_MESSAGE_IMAGE);
      loadFolders();
    }
    setState(() {
      _isLoading = false;
    });
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
        child: _isLoading
            ? CircularProgressIndicator(
                backgroundColor: Colors.teal,
              )
            : FolderWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scanDocument,
        child: Icon(Icons.camera_enhance),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
