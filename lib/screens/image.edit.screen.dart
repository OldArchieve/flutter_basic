import 'package:basic/models/model.dart' as model;
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:photo_view/photo_view.dart';

class ImageEditScreen extends StatelessWidget {
  static const routeName = "image-edit-screen";

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final model.Image image = args["imageResult"];

    return Scaffold(
      appBar: AppBar(
        title: Text('${image.title}'),
      ),
      body: Container(
        child: GestureDetector(
          child: PhotoView(
            imageProvider: FileImage(
              File(image.imageUrl),
            ),
          ),
          onVerticalDragUpdate: (details) {
            if (details.delta.dy > 0) {
              //Navigator.of(context).pop();
            }
          },
        ),
      ),
    );
  }
}
