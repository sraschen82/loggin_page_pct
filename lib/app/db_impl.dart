import 'dart:async';

import 'package:loggin_page_pct/app/loggin/credentials_entity.dart';
import 'package:loggin_page_pct/app/user_entity.dart';

class DbImpl {
  DbImpl() {
    fecthUser();
  }
  late User _user;
  User get user => _user;

  Future<User> fecthUser() async {
    await Future.delayed(const Duration(seconds: 1));
    _user = User.empty();
    _user = User(
        credentials: Credentials(
            name: 'Samuel Raschen',
            email: 'sraschen@gmail.com',
            password: '123456'));

    // print('Usuário carregado com sucesso. ${_user.credentials.name}');
    return _user;
  }

  Future<void> saveUser({required User user}) async {
    await Future.delayed(const Duration(seconds: 1));
    _user = user;

    // print('Usuário salvo com sucesso.');
  }
}
