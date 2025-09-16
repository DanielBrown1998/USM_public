class UserisNotAvailableToMonitoriaException implements Exception {
  final String message;
  UserisNotAvailableToMonitoriaException(this.message);
  @override
  String toString() {
    return message;
  }
}

class UserAlreadyMarkDateException implements Exception {
  final String message;
  UserAlreadyMarkDateException(this.message);
  @override
  String toString() {
    return message;
  }
}

class StatusMOnitoriaException implements Exception {
  final String message;
  StatusMOnitoriaException(this.message);
  @override
  String toString() {
    return message;
  }
}

class MonitoriaExceedException implements Exception {
  final String message;
  MonitoriaExceedException(this.message);
  @override
  String toString() {
    return message;
  }
}
