class Validators {
  static const usernameError = "Please enter valid email or phone number";
  static const passwordError = "Password should be minimum 4 characters";
  static const passwordMatchError = "Password mismatch";
  static const emailError = "Please enter valid email Id";
  static const phoneError = "Please enter valid phone number";
  static const nameError = "Please enter valid name";
  static const passCodeError = "Field cannot be empty";

  static String isValidUserName(String username) {
    var msg;
    if (username.isNotEmpty &&
        (isEmailValid(username) || isValidNumber(username))) {
      msg = "";
    } else {
      msg = usernameError;
    }
    return msg;
  }

  static String isValidEmailId(String emailId) {
    var msg;
    if (emailId.isNotEmpty && isEmailValid(emailId)) {
      msg = "";
    } else {
      msg = emailError;
    }
    return msg;
  }

  static String isValidOtp(String otp) {
    var msg;
    if (otp.isNotEmpty && otp.length == 4) {
      msg = "";
    } else {
      msg = "Enter valid otp";
    }
    return msg;
  }

  static String isValidPhoneNo(String number) {
    var msg;
    if (number.isNotEmpty && isValidNumber(number)) {
      msg = "";
    } else {
      msg = phoneError;
    }
    return msg;
  }

  static String isValidName(String name) {
    String patttern = r'^[a-z A-Z,.\-]+$';
    RegExp regExp = new RegExp(patttern);

    var msg;
    if (name.isNotEmpty && regExp.hasMatch(name)) {
      msg = "";
    } else {
      msg = nameError;
    }
    return msg;
  }

  static bool isEmailValid(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  static bool isValidNumber(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (!regExp.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  static String isValidPassword(String password) {
    var msg;
    if (password.isNotEmpty && password.length >= 4) {
      msg = "";
    } else {
      msg = passwordError;
    }

    return msg;
  }

  static String isSamePasswords(String password1, String password2) {
    var msg;
    if (password1 == password2) {
      msg = "";
    } else {
      msg = passwordMatchError;
    }

    return msg;
  }

  static String isValidPasswords(String password1, String password2) {
    var msg;
    if (password2.isNotEmpty && password2.length >= 4) {
      if (password1 == password2) {
        msg = "";
      } else {
        msg = passwordMatchError;
      }
    } else {
      msg = passwordError;
    }

    return msg;
  }

  static String isEmpty(String value) {
    var msg;

    if (value.isNotEmpty) {
      msg = "";
    } else {
      msg = passCodeError;
    }

    return msg;
  }
}
