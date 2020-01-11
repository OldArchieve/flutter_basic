import 'package:basic/stores/folder.store.dart';
import 'package:basic/widgets/custom_floating_button.widget.dart';
import 'package:basic/widgets/folder_image.widget.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:basic/models/model.dart' as model;
import 'package:basic/stores/image.store.dart';
import 'package:provider/provider.dart';
import 'package:scanny/scanny.dart';

import '../constants/constants.dart';
import '../widgets/custom_alert_dialog.widget.dart';

class FolderDetailScreen extends StatefulWidget {
  static const routeName = "folder-detail-screen";

  @override
  _FolderDetailScreenState createState() => _FolderDetailScreenState();
}

class _FolderDetailScreenState extends State<FolderDetailScreen> {
  bool _isLoading = false;

  void _scanAndSaveImage(FolderStore folderStore, folderId) {
    setState(() {
      _isLoading = true;
    });
    final scanny = new Scanny();
    scanny.askPermissions;
    scanny.callScanner;
    scanny.getImageBytes.listen((imageBytes) {
      _saveImage(folderStore, folderId, imageBytes);
    });
  }

  void _saveImage(FolderStore folderStore, folderId, imageBytes) {
    folderStore.saveImageWithFolderId(folderId, imageBytes).then((result) {
      if (result == Constants.SUCCESS) {
        setState(() {
          _isLoading = false;
        });
        _showAlert(
            title: Constants.SUCCESS,
            content: Constants.SUCCESS_MESSAGE_IMAGE,
            onPressed: () {});
      }
    }).catchError(
      (onError) {
        setState(() {
          _isLoading = false;
        });
        _showAlert(title: Constants.ERROR_OCCURED, content: onError);
      },
    );
  }

  void _showAlert({String title, String content, Function onPressed}) {
    CustomAlertDialog(
      content: content,
      title: title,
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final imageStore = Provider.of<ImageStore>(context);
    final folderStore = Provider.of<FolderStore>(context);
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final folderId = args["id"];
    final title = args["title"];

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.teal,
            ),
          )
        : FutureBuilder(
            future: imageStore.findImagesByFolderId(folderId),
            builder: (_, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.teal,
                    ),
                  );
                default:
                  if (snapshot.hasError) {
                    return CustomAlertDialog(
                      title: Constants.ERROR_OCCURED,
                      content: snapshot.error,
                      onPressed: () {},
                    );
                  } else {
                    List<model.Image> result = snapshot.data;
                    return Scaffold(
                      appBar: AppBar(
                        title: Text('$title'),
                      ),
                      body: Column(
                        children: <Widget>[
                          Expanded(
                            child: GridView.builder(
                              itemCount: result.length,
                              itemBuilder: (_, index) {
                                return FolderImageWidget(
                                    result[index], index + 1);
                              },
                              padding: EdgeInsets.all(10),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: screenSize.width / 2,
                                      childAspectRatio: 1 / 1.5,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                            ),
                          ),
                        ],
                      ),
                      floatingActionButton: CustomFloatingButton(
                        onPressed: () {
                          _scanAndSaveImage(folderStore, folderId);
                          //folderStore.
                        },
                      ),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerFloat,
                    );
                  }
              }
            },
          );
  }
}
