enum FailureType { HttpException, FormatException, SocketException, Error404 }

class Failure {
  var message;
  FailureType type;
  Failure({this.message, this.type});
}

enum Status { active, loading, done }

class InstanceStatus {
  Failure failure;
  Status status;
  InstanceStatus({this.failure, this.status = Status.active});
}