import 'package:basic/screens/image.edit.screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class FolderImageWidget extends StatelessWidget {
  final imageResult;
  final index;

  FolderImageWidget(this.imageResult, this.index);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: GridTile(
        child: GestureDetector(
          child: Image.file(
            File(imageResult.imageUrl),
            fit: BoxFit.fitHeight,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              ImageEditScreen.routeName,
              arguments: {"imageResult": imageResult},
            );
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            '$index',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
