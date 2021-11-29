class CustomException implements Exception {
  static const String ERROR_NO_INTERNET_CONNECTION =
      "Unable to connect to Fitbeat. Please check your internet connection and try again.";
  static const String ERROR_CRASH_MSG =
      "Something went wrong, Please try again later.";

  static const String DEFAULT_CONNECT_TIMEOUT_MSG =
      "We encountered an unexpected error.";

  static const String INVALID_EMAIL_PASSWORD = "Invalid username or password";
  static const String INVALID_EMAIL = "Enter email id";
  static const String INVALID_PASSWORD = "Enter password";

  static const ERROR_CONNECTION = 001;
  static const ERROR_DEFAULT = 002;

  String _message;
  final int _code;
  final dynamic _response;

  CustomException([this._code = 0, this._message, this._response]);

  int getCode() => _code;

  String getMsg() => _message;

  dynamic getResponse() => _response;

  String toString() {
    return "$_message";
  }
}
