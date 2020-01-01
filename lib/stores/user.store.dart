import 'package:basic/constants/constants.dart';
import 'package:basic/exception/UserException.dart';
import 'package:basic/helpers/db_helper.dart';
import 'package:mobx/mobx.dart';

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
    final arguments = {"email": email, "active": 1};
    final result = await DBHelper.find(Constants.USERS_TABLE_NAME, arguments);

    if (result.isEmpty) {
      final arguments = {"email": email, "password": password, "active": 1};
      DBHelper.insert(Constants.USERS_TABLE_NAME, arguments);
      _isUserLoggedIn = true;
    } else {
      final user = result.first;
      _isUserLoggedIn = user["active"] == 1 ? true : false;
    }
  }

  @action
  Future<void> userSignIn(final email, final password) async {
    final arguments = {"email": email, "password": password, "active": 1};
    final result = await DBHelper.find(Constants.USERS_TABLE_NAME, arguments);
    if (result.isEmpty) {
      throw UserException(Constants.USER_DOES_NOT_EXISTS_EXCEPTION_MESSAGE);
    } else {
      final user = result.first;
      _isUserLoggedIn = user["active"] == 1 ? true : false;
    }
  }

  @action
  Future<void> autoLogin() async {
    final user = await DBHelper.findFirst(Constants.USERS_TABLE_NAME);
    if (user != null) {
      _isUserLoggedIn = user["active"] == 1 ? true : false;
    }
  }
}
