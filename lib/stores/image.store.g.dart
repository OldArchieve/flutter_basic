// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ImageStore on _ImageStore, Store {
  final _$imagesAtom = Atom(name: '_ImageStore.images');

  @override
  List<Image> get images {
    _$imagesAtom.context.enforceReadPolicy(_$imagesAtom);
    _$imagesAtom.reportObserved();
    return super.images;
  }

  @override
  set images(List<Image> value) {
    _$imagesAtom.context.conditionallyRunInAction(() {
      super.images = value;
      _$imagesAtom.reportChanged();
    }, _$imagesAtom, name: '${_$imagesAtom.name}_set');
  }
}
