import 'dart:io';
import 'package:basic/models/model.dart' as model;
import 'package:basic/stores/image.store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../widgets/custom_alert_dialog.widget.dart';

class FolderDetailScreen extends StatelessWidget {
  static const routeName = "folder-detail-screen";

  @override
  Widget build(BuildContext context) {
    final imageStore = Provider.of<ImageStore>(context);
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final id = args["id"];

    return FutureBuilder(
        future: imageStore.findImagesByFolderId(id),
        builder: (_, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator(
                backgroundColor: Colors.teal,
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
                return GridView.builder(
                  itemCount: result.length,
                  itemBuilder: (_, index) => GridTile(
                    child: Image.file(File(result[index].imageUrl)),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                );
              }
          }
        });
  }
}
