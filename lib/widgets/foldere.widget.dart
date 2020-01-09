import 'package:basic/screens/folder.detail.screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class FolderWidget extends StatelessWidget {
  final folders;

  FolderWidget(this.folders);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: folders.length,
      itemBuilder: (_, index) => Column(
        children: <Widget>[
          Container(
            height: 80,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 1),
            child: ListTile(
              leading: Image.file(
                File(folders[index].imageUrl),
                fit: BoxFit.fill,
              ),
              title: Text(folders[index].title),
              //subtitle: Text(_items.getItems[index].description),
              selected: false,
              onTap: () {
                Navigator.of(context).pushNamed(FolderDetailScreen.routeName,
                    arguments: {"id": folders[index].id});
              },
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
