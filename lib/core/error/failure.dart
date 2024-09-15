// coverage:ignore-file
class Failure {
  final String message;

  Failure([this.message = 'An unexpected error occured.']);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}
