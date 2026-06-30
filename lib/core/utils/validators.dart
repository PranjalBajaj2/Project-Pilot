class Validators {
  Validators._();

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your name";
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your email";
    }

    final emailRegex =
    RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value.trim())) {
      return "Enter a valid email";
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your password";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;
  }

  static String? confirmPassword(
      String? value,
      String password,
      ) {
    if (value == null || value.isEmpty) {
      return "Confirm your password";
    }

    if (value != password) {
      return "Passwords do not match";
    }

    return null;
  }

}
