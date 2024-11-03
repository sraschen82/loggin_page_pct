import 'dart:async';

import 'package:loggin_page_pct/app/db_impl.dart';
import 'package:loggin_page_pct/app/loggin/credentials_entity.dart';
import 'package:loggin_page_pct/app/loggin/login_states.dart';
import 'package:loggin_page_pct/app/user_entity.dart';

class LoginStore {
  DbImpl db = DbImpl();

  LoginStates logginState = UnLogged();

  final _stateController = StreamController<LoginStates>.broadcast();

  Stream<LoginStates> get stateStream => _stateController.stream;

  Stream<LoginStates> checkFastLogin() async* {
    late LoginStates state;
    await db.fecthUser();

    db.user.credentials.name.isNotEmpty
        ? state = FastLogin()
        : state = UnLogged();

    _stateController.add(state);

    yield state;
  }

  Stream<LoginStates> logginEvent(
      {required String email, required String password}) async* {
    late LoginStates state;

    String checkEmail = '';
    email.isEmpty ? checkEmail = db.user.credentials.email : checkEmail = email;
    db.user.credentials.password == password &&
            checkEmail == db.user.credentials.email
        ? {
            state = Logged(
                name: db.user.credentials.name,
                email: db.user.credentials.email,
                password: db.user.credentials.password),
          }
        : {
            state = FastLogin(),
          };

    _stateController.sink.add(state);
    yield state;
  }

  Stream<LoginStates> registerEvent({required Credentials credentials}) async* {
    late LoginStates state;
    try {
      await db.saveUser(user: User(credentials: credentials));
      state = Logged(
          name: credentials.name,
          email: credentials.email,
          password: credentials.password);
    } catch (e) {
      state = UnLogged();
    }
    _stateController.sink.add(state);
    yield state;
  }

  userRegister({required Credentials credentials}) async {}

  void dispose() => _stateController.close();
}
