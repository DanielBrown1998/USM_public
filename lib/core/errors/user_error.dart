
class UserControllerException {
  final String message;
  UserControllerException(this.message);
  @override
  String toString() {
    return message;
  }
}

class UserNotFoundException implements Exception {
  final String message;
  UserNotFoundException(this.message);
  @override
  String toString() {
    return message;
  }
}