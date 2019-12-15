// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Items on _Items, Store {
  final _$_itemsAtom = Atom(name: '_Items._items');

  @override
  List<Item> get _items {
    _$_itemsAtom.context.enforceReadPolicy(_$_itemsAtom);
    _$_itemsAtom.reportObserved();
    return super._items;
  }

  @override
  set _items(List<Item> value) {
    _$_itemsAtom.context.conditionallyRunInAction(() {
      super._items = value;
      _$_itemsAtom.reportChanged();
    }, _$_itemsAtom, name: '${_$_itemsAtom.name}_set');
  }
}
