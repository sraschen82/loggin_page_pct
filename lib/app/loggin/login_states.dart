sealed class LoginStates {}

class UnLogged extends LoginStates {}

class FastLogin extends LoginStates {}

class Logged extends LoginStates {
  final String name;
  final String email;
  final String password;

  Logged({required this.name, required this.email, required this.password});
}
