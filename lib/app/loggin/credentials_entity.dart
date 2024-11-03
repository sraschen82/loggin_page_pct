class Credentials {
  final String name;
  final String email;
  final String password;

  Credentials(
      {required this.name, required this.email, required this.password});

  factory Credentials.empty() => Credentials(name: '', email: '', password: '');
}
