import '../models/model.dart' as model;
import 'package:basic/screens/folder.detail.screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class FolderWidget extends StatelessWidget {
  final List<model.Folder> folders;

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
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 80,
                  minWidth: 80,
                  maxHeight: 80,
                  maxWidth: 80,
                ),
                child: Image.file(
                  File(folders[index].imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
              title: Text(folders[index].title),
              subtitle: Text(
                DateFormat('dd-MM-yyy').format(
                  DateTime.fromMillisecondsSinceEpoch(folders[index].createdAt),
                ),
              ),
              selected: false,
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
              ),
              onTap: () {
                Navigator.of(context).pushNamed(FolderDetailScreen.routeName,
                    arguments: {
                      "id": folders[index].id,
                      "title": folders[index].title
                    });
              },
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
