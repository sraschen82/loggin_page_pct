import 'package:flutter/material.dart';
import 'package:loggin_page_pct/app/app_colors.dart';
import 'package:loggin_page_pct/app/db_impl.dart';
import 'package:loggin_page_pct/app/home_page.dart';
import 'package:loggin_page_pct/app/loggin/components/email_tff.dart';
import 'package:loggin_page_pct/app/loggin/components/name_tff.dart';
import 'package:loggin_page_pct/app/loggin/credentials_entity.dart';
import 'package:loggin_page_pct/app/loggin/login_states.dart';
import 'package:loggin_page_pct/app/loggin/login_store.dart';
import 'package:loggin_page_pct/app/loggin/validate.dart';

class LoginPage extends StatefulWidget {
  final bool isRegisterPage;
  const LoginPage({required this.isRegisterPage, super.key});

  @override
  State<LoginPage> createState() => _LogginPageState();
}

class _LogginPageState extends State<LoginPage> {
  final LoginStore _store = LoginStore();

  late bool isRegister;
  String userName = '';
  String userPassword = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isRegister = widget.isRegisterPage;

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await DbImpl().fecthUser().then((value) {
          userName = value.credentials.name;
          userPassword = value.credentials.password;
        });

        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _store.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    clearControllers() {
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmpasswordController.clear();
    }

    validatorForm() async {
      if (isRegister) {
        if (Validate.register(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
            confirmPassword: confirmpasswordController.text)) {
          final Credentials credentials = Credentials(
              name: nameController.text,
              email: emailController.text,
              password: passwordController.text);

          _store.registerEvent(credentials: credentials).listen(
            (event) {
              if (event is Logged) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomePage()));
              }
            },
          );
          clearControllers();
        }
      } else {
        _store
            .logginEvent(
                email: emailController.text, password: passwordController.text)
            .listen(
          (event) {
            if (event is Logged) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()));
            }
          },
        );
        clearControllers();
      }
    }

    return Card(
      child: DecoratedBox(
        decoration: BoxDecoration(gradient: MyColors().gradientHomePage()),
        child: SizedBox(
          height: height * .9,
          width: width * .98,
          child: Center(
            child: Column(
              children: [
                Flexible(
                  flex: 2,
                  child: Center(
                    child: isRegister
                        ? Text(
                            'REGISTER',
                            style: TextStyle(
                                color: MyColors().titleColor,
                                fontSize: 50,
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            'LOGIN',
                            style: TextStyle(
                                color: MyColors().titleColor,
                                fontSize: 50,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 50),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if (isRegister)
                            NameTextFormField(nameController: nameController),
                          if (isRegister)
                            Divider(color: Colors.white.withOpacity(0)),
                          if (isRegister || userName == '')
                            EmailTextFormField(
                                emailController: emailController),
                          if (!isRegister && userName == '')
                            Divider(color: Colors.white.withOpacity(0)),
                          if (!isRegister && userName.length > 1)
                            Column(
                              children: [
                                const Text('Wellcome'),
                                Text(
                                  userName,
                                  style: const TextStyle(
                                    fontSize: 30,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Divider(
                                  color: Colors.white.withOpacity(0),
                                  height: 50,
                                ),
                              ],
                            ),
                          if (isRegister)
                            Divider(color: Colors.white.withOpacity(0)),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.always,
                            controller: passwordController,
                            autofocus: !isRegister ? true : false,
                            obscureText: true,
                            textInputAction: !isRegister
                                ? TextInputAction.done
                                : TextInputAction.next,
                            cursorColor: Colors.white,
                            onFieldSubmitted: (value) =>
                                !isRegister ? validatorForm() : {},
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              hoverColor: Colors.white,
                              prefixIcon: const Icon(Icons.password,
                                  color: Colors.white),
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              contentPadding: const EdgeInsets.all(30),
                              hintText: '  Your Password',
                              hintStyle: const TextStyle(color: Colors.white),
                              label: const Text('  Password',
                                  style: TextStyle(color: Colors.white)),
                              border: const OutlineInputBorder(
                                gapPadding: 5,
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            enableSuggestions: true,
                            onChanged: (value) {
                              if (!isRegister &&
                                  value.isNotEmpty &&
                                  value == userPassword) {
                                validatorForm();
                              }
                            },
                            validator: (value) =>
                                Validate.password(password: value),
                          ),
                          Divider(color: Colors.white.withOpacity(0)),
                          if (isRegister)
                            TextFormField(
                              autovalidateMode: AutovalidateMode.always,
                              controller: confirmpasswordController,
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                              cursorColor: Colors.white,
                              onFieldSubmitted: (value) => validatorForm(),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                hoverColor: Colors.white,
                                prefixIcon: const Icon(Icons.password,
                                    color: Colors.white),
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                contentPadding: const EdgeInsets.all(30),
                                hintText: '  Your Password',
                                hintStyle: const TextStyle(color: Colors.white),
                                label: const Text('  Confirm Password',
                                    style: TextStyle(color: Colors.white)),
                                border: const OutlineInputBorder(
                                  gapPadding: 5,
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              enableSuggestions: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return null;
                                } else if (value.length > 5 &&
                                    value != passwordController.text) {
                                  return 'Senha incorreta.';
                                }

                                return null;
                              },
                            ),
                          Divider(color: Colors.white.withOpacity(0)),
                          TextButton(
                              style: ButtonStyle(
                                  backgroundColor: isRegister &&
                                          Validate.register(
                                              name: nameController.text,
                                              email: emailController.text,
                                              password: passwordController.text,
                                              confirmPassword:
                                                  confirmpasswordController
                                                      .text)
                                      ? const WidgetStatePropertyAll(
                                          Colors.blueAccent)
                                      : const WidgetStatePropertyAll(
                                          Color.fromARGB(255, 143, 140, 140)),
                                  elevation: const WidgetStatePropertyAll(30),
                                  minimumSize: const WidgetStatePropertyAll(
                                    Size(300, 60),
                                  ),
                                  maximumSize: const WidgetStatePropertyAll(
                                      Size(400, 80)),
                                  shape: const WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))))),
                              onPressed: () {
                                validatorForm();
                              },
                              child: isRegister
                                  ? const Text('Send')
                                  : const Text('Enter')),
                          Divider(color: Colors.white.withOpacity(0)),
                          if (!isRegister)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: width * .4,
                                    child: const Text(
                                      'Don´t hava a accont?',
                                      style: TextStyle(fontSize: 15),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        clearControllers();
                                        isRegister = !isRegister;
                                      });
                                    },
                                    child: const Text(
                                      'SING UP',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                          if (isRegister)
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (context) => const LoginPage(
                                                isRegisterPage: false,
                                              )));
                                },
                                child: const Text(
                                  'Back to LOGIN.',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                )),
                          if (!isRegister && userName.length > 1)
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    clearControllers();
                                    userName = '';
                                  });
                                },
                                child: Text(
                                  'Sign in with another account.',
                                  style: TextStyle(
                                      color: MyColors().paletteColor2,
                                      fontWeight: FontWeight.bold),
                                )),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
