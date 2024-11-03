import 'package:flutter/material.dart';
import 'package:loggin_page_pct/app/home_page.dart';
import 'package:loggin_page_pct/app/loggin/login_states.dart';
import 'package:loggin_page_pct/app/loggin/login_store.dart';
import 'package:loggin_page_pct/app/loggin/pages/login_page.dart';

class LoginSwitchPage extends StatefulWidget {
  const LoginSwitchPage({super.key});

  @override
  State<LoginSwitchPage> createState() => _LoginSwitchPageState();
}

class _LoginSwitchPageState extends State<LoginSwitchPage> {
  final LoginStore store = LoginStore();

  @override
  void initState() {
    super.initState();

    store.checkFastLogin().listen(
          (event) {},
        );
    store.stateStream.listen(
      (event) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: StreamBuilder(
        stream: store.stateStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: SizedBox(child: CircularProgressIndicator()));
          }
          if (snapshot.hasData) {
            switch (snapshot.data) {
              case null:
                return const LoginPage(isRegisterPage: true);

              case UnLogged():
                return const LoginPage(isRegisterPage: true);

              case FastLogin():
                return const LoginPage(isRegisterPage: false);

              case Logged():
                return const HomePage();
            }
          } else {
            return const LoginPage(isRegisterPage: true);
          }
        },
      ),
    );
  }
}
