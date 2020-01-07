import 'package:basic/constants/constants.dart';
import 'package:basic/exception/SQLException.dart';
import 'package:basic/exception/UserException.dart';
import 'package:basic/models/model.dart';
import 'package:mobx/mobx.dart';

import '../constants/constants.dart';

part 'user.store.g.dart';

class UsersStore = _UsersStore with _$UsersStore;

abstract class _UsersStore with Store {
  @observable
  bool _isUserLoggedIn = false;

  @computed
  bool get isUserLoggedIn {
    return _isUserLoggedIn;
  }

  @action
  Future<void> userSignUp(final email, final password) async {
    final user = await User()
        .select()
        .email
        .equals(email)
        .and
        .isActive
        .equals(true)
        .toSingle();

    if (user != null) {
      _isUserLoggedIn = user.isActive;
    } else {
      await _tryToSaveUser(email, password);
    }
  }

  Future<void> _tryToSaveUser(email, password) async {
    final result = await User(
            email: email,
            password: password,
            isActive: true,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            updatedAt: DateTime.now().millisecondsSinceEpoch)
        .save();

    if (result > 0) {
      _isUserLoggedIn = true;
    } else {
      throw SQLException(Constants.SQL_EXCEPTION_MESSAGE);
    }
  }

  @action
  Future<void> userSignIn(final email, final password) async {
    final user = await User()
        .select()
        .email
        .equals(email)
        .and
        .password
        .equals(password)
        .and
        .isActive
        .equals(true)
        .toSingle();
    if (user == null) {
      throw UserException(Constants.USER_DOES_NOT_EXISTS_EXCEPTION_MESSAGE);
    } else {
      _isUserLoggedIn = user.isActive;
    }
  }

  @action
  Future<void> autoLogin() async {
    final user = await User().select().toSingle();
    if (user != null) {
      _isUserLoggedIn = user.isActive;
    }
  }
}
