abstract class Validate {
  static String? name({required String? name}) {
    String? error;
    if (name == null || name.isEmpty) {
      return null;
    } else if (name.isEmpty || name.length < 2) {
      error = 'Deve ter, ao menos, duas letras';
    }

    return error;
  }

  static String? email({required String? email}) {
    String? error;
    if (email == null || email.isEmpty) {
      return null;
    } else if (!email.contains('@') ||
        !email.contains('.') ||
        email.substring(email.indexOf('@'), email.lastIndexOf('.')).length <
            3 ||
        email.substring(email.lastIndexOf('.'), email.length).length < 3) {
      error = 'E-mail inválido';
    }
    return error;
  }

  static String? password({required String? password}) {
    String? error;
    if (password == null || password.isEmpty) {
      return null;
    } else if (password.length < 6) {
      error = 'Pelo menos 6 caracteres.';
    }

    return error;
  }

  static bool register(
      {required String name,
      required String email,
      required String password,
      required String confirmPassword}) {
    bool isValid = false;

    if (Validate.name(name: name) == null &&
        name.isNotEmpty &&
        Validate.email(email: email) == null &&
        email.isNotEmpty &&
        Validate.password(password: password) == null &&
        password.isNotEmpty &&
        password == confirmPassword) {
      isValid = true;
    }

    return isValid;
  }

  static void form() {


    
  }
}
