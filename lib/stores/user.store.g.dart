// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UsersStore on _UsersStore, Store {
  Computed<bool> _$isUserLoggedInComputed;

  @override
  bool get isUserLoggedIn =>
      (_$isUserLoggedInComputed ??= Computed<bool>(() => super.isUserLoggedIn))
          .value;

  final _$_isUserLoggedInAtom = Atom(name: '_UsersStore._isUserLoggedIn');

  @override
  bool get _isUserLoggedIn {
    _$_isUserLoggedInAtom.context.enforceReadPolicy(_$_isUserLoggedInAtom);
    _$_isUserLoggedInAtom.reportObserved();
    return super._isUserLoggedIn;
  }

  @override
  set _isUserLoggedIn(bool value) {
    _$_isUserLoggedInAtom.context.conditionallyRunInAction(() {
      super._isUserLoggedIn = value;
      _$_isUserLoggedInAtom.reportChanged();
    }, _$_isUserLoggedInAtom, name: '${_$_isUserLoggedInAtom.name}_set');
  }

  final _$userSignUpAsyncAction = AsyncAction('userSignUp');

  @override
  Future<void> userSignUp(dynamic email, dynamic password) {
    return _$userSignUpAsyncAction.run(() => super.userSignUp(email, password));
  }

  final _$userSignInAsyncAction = AsyncAction('userSignIn');

  @override
  Future<void> userSignIn(dynamic email, dynamic password) {
    return _$userSignInAsyncAction.run(() => super.userSignIn(email, password));
  }

  final _$autoLoginAsyncAction = AsyncAction('autoLogin');

  @override
  Future<void> autoLogin() {
    return _$autoLoginAsyncAction.run(() => super.autoLogin());
  }
}
