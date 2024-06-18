class Failure {
  final String? message;
  final int? statusCode;
  final dynamic data;
  final dynamic errors;

  Failure({this.message, this.statusCode, this.data, this.errors});

  @override
  String toString() => message!;
}
