import 'dart:io';
import 'dart:typed_data';

import '../exception/SQLException.dart';
import '../models/model.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:developer';

part 'folder.store.g.dart';

class FolderStore = _FolderStore with _$FolderStore;

abstract class _FolderStore with Store {
  List<Folder> _folders;

  @computed
  List<Folder> get folders {
    return _folders;
  }

  @action
  Future<String> createFolderAndSaveImage(Uint8List imageArray) async {
    try {
      final result = await Folder(
              title: DateTime.now().toIso8601String(),
              createdAt: DateTime.now().millisecondsSinceEpoch,
              updatedAt: DateTime.now().millisecondsSinceEpoch)
          .save();

      if (result > 0) {
        await _saveImage(result, imageArray);
      } else {
        throw SQLException("Could not save Folder");
      }
    } catch (err) {
      throw SQLException(err);
    }
    return "sucess";
  }

  Future _saveImage(int result, Uint8List imageArray) async {
    final imageName = "${DateTime.now().millisecondsSinceEpoch.toString()}.png";
    final imageResult = await Image(
            folderId: result,
            imageUrl: await _createFileFromBytes(imageArray, imageName),
            createdAt: DateTime.now().millisecondsSinceEpoch,
            updatedAt: DateTime.now().millisecondsSinceEpoch,
            title: imageName)
        .save();

    if (imageResult > 0) {
      log("Image save successfully");
    } else {
      throw SQLException("Could not save image");
    }
  }

  Future<String> _createFileFromBytes(final bytes, final imageName) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    String fullPath = "$dir/$imageName";
    print("storing at $fullPath");
    File file = File(fullPath);
    await file.writeAsBytes(bytes);
    print(file.path);

    final result = await ImageGallerySaver.saveImage(bytes);
    print(result);
    return file.path;
  }
}
