import '../stores/items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ItemWidget extends StatelessWidget {
  final _items = Items();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return ListView.builder(
          itemCount: _items.getItems.length,
          itemBuilder: (ctx, index) => Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(_items.getItems[index].imageUrl),
                ),
                title: Text(_items.getItems[index].title),
                subtitle: Text(_items.getItems[index].description),
                selected: false,
                onTap: () {},
              ),
              Divider(),
            ],
          ),
        );
      },
    );
  }
}
