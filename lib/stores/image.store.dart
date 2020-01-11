import 'package:basic/models/model.dart';
import 'package:mobx/mobx.dart';

part 'image.store.g.dart';

class ImageStore = _ImageStore with _$ImageStore;

abstract class _ImageStore with Store {
  @observable
  List<Image> images;

  Future<List<Image>> findImagesByFolderId(int id) async {
    final imageList = await Image().select().folderId.equals(id).toList();
    return imageList;
  }
}
