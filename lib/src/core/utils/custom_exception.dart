class CustomException implements Exception {
  String cause;

  CustomException(this.cause);
}

class UnAuthorizeException implements Exception {
  UnAuthorizeException();
}
