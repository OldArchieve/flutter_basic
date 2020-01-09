// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FolderStore on _FolderStore, Store {
  final _$foldersAtom = Atom(name: '_FolderStore.folders');

  @override
  List<Folder> get folders {
    _$foldersAtom.context.enforceReadPolicy(_$foldersAtom);
    _$foldersAtom.reportObserved();
    return super.folders;
  }

  @override
  set folders(List<Folder> value) {
    _$foldersAtom.context.conditionallyRunInAction(() {
      super.folders = value;
      _$foldersAtom.reportChanged();
    }, _$foldersAtom, name: '${_$foldersAtom.name}_set');
  }

  final _$createFolderAndSaveImageAsyncAction =
      AsyncAction('createFolderAndSaveImage');

  @override
  Future<String> createFolderAndSaveImage(Uint8List imageArray) {
    return _$createFolderAndSaveImageAsyncAction
        .run(() => super.createFolderAndSaveImage(imageArray));
  }

  final _$fetchFoldersAsyncAction = AsyncAction('fetchFolders');

  @override
  Future<List<Folder>> fetchFolders() {
    return _$fetchFoldersAsyncAction.run(() => super.fetchFolders());
  }
}
