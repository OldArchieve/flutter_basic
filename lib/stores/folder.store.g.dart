// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FolderStore on _FolderStore, Store {
  Computed<List<Folder>> _$foldersComputed;

  @override
  List<Folder> get folders =>
      (_$foldersComputed ??= Computed<List<Folder>>(() => super.folders)).value;

  final _$createFolderAndSaveImageAsyncAction =
      AsyncAction('createFolderAndSaveImage');

  @override
  Future<String> createFolderAndSaveImage(Uint8List imageArray) {
    return _$createFolderAndSaveImageAsyncAction
        .run(() => super.createFolderAndSaveImage(imageArray));
  }
}
