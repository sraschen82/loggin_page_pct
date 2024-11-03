import 'package:loggin_page_pct/app/loggin/credentials_entity.dart';

class User {
  final Credentials credentials;

  User({required this.credentials});

  factory User.empty() => User(credentials: Credentials.empty());
}
