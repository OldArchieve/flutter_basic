import 'package:mobx/mobx.dart';

part 'user.store.g.dart';

class UsersStore = _UsersStore with _$UsersStore;

abstract class _UsersStore with Store {
  @observable
  bool _isUserLoggedIn = false;

  bool get isUserLoggedIn {
    return _isUserLoggedIn;
  }

  @action
  Future<void> userSignIn(final email, final password) async {
    // call sql
    _isUserLoggedIn = true;
  }
}
