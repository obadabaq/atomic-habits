abstract class Failure {
  final String error;

  const Failure(this.error);
}

class DatabaseFailure extends Failure {
  DatabaseFailure(super.error);
}
