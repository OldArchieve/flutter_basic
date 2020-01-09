import 'package:basic/models/model.dart' as model;
import 'package:basic/stores/folder.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../constants/constants.dart';
import 'custom_alert_dialog.widget.dart';

class FolderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _folderStore = Provider.of<FolderStore>(context);

    return Observer(
      builder: (_) => _folderStore.folders == null
          ? Text("Scan for docs ")
          : ListView.builder(
              itemCount: _folderStore.folders.length,
              itemBuilder: (_, index) => Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      child: Image.file(
                          File(_folderStore.folders[index].imageUrl)),
                    ),
                    title: Text(_folderStore.folders[index].title),
                    //subtitle: Text(_items.getItems[index].description),
                    selected: false,
                    onTap: () {},
                  ),
                  Divider(),
                ],
              ),
            ),
    );
  }
}
