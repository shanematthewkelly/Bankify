class EmailValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }

    if (value.length < 5) {
      return 'Email must be at least 5 characters';
    }
    return null;
  }
}

class PasswordValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }
}
