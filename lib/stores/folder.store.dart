import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';

import '../constants/constants.dart';
import '../exception/SQLException.dart';
import '../models/model.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:developer';

part 'folder.store.g.dart';

class FolderStore = _FolderStore with _$FolderStore;

abstract class _FolderStore with Store {
  @observable
  List<Folder> folders;

  @action
  Future<String> createFolderAndSaveImage(Uint8List imageArray) async {
    try {
      final imageName =
          "${DateTime.now().millisecondsSinceEpoch.toString()}.png";

      String imagePath = await _createFileFromBytes(imageArray, imageName);

      final result = await Folder(
              imageUrl: imagePath,
              title: DateFormat('dd-MM-yyyy hh:mm:ss').format(DateTime.now()),
              createdAt: DateTime.now().millisecondsSinceEpoch,
              updatedAt: DateTime.now().millisecondsSinceEpoch)
          .save();

      if (result > 0) {
        await _saveImage(result, imagePath, imageName);
      } else {
        throw SQLException(Constants.ERROR_SAVE_FOLDER);
      }
    } catch (err) {
      throw SQLException(err);
    }
    return Constants.SUCCESS;
  }

  @action
  Future<List<Folder>> fetchFolders() async {
    final folderList = await Folder().select().toList();
    folders = folderList;
    return folderList;
  }

  Future _saveImage(int result, String imagePath, String imageName) async {
    final imageResult = await Image(
            folderId: result,
            imageUrl: imagePath,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            updatedAt: DateTime.now().millisecondsSinceEpoch,
            title: imageName)
        .save();

    if (imageResult > 0) {
      log(Constants.SUCCESS_MESSAGE_IMAGE);
    } else {
      throw SQLException(Constants.ERROR_SAVE_IMAGE);
    }
  }

  Future<String> _createFileFromBytes(final bytes, final imageName) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    String fullPath = "$dir/$imageName";
    log("storing at $fullPath");
    File file = File(fullPath);
    await file.writeAsBytes(bytes);
    log(file.path);

    final result = await ImageGallerySaver.saveImage(bytes);
    log(result);
    return file.path;
  }

  Future<Folder> findFolderById(String id) async {
    final folder = await Folder().getById(int.parse(id));
    return folder;
  }

  Future<String> saveImageWithFolderId(
      int folderId, Uint8List imageArray) async {
    try {
      final imageName =
          "${DateTime.now().millisecondsSinceEpoch.toString()}.png";
      String imagePath = await _createFileFromBytes(imageArray, imageName);
      await _saveImage(folderId, imagePath, imageName);
    } catch (err) {
      throw SQLException(err);
    }
    return Constants.SUCCESS;
  }
}
