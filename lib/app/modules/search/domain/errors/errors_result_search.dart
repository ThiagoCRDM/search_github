// ignore_for_file: overridden_fields

class Failure implements Exception {
  final String? message;
  const Failure({this.message});
}

class InvalidSearchText extends Failure {
  @override
  final String? message;
  const InvalidSearchText({this.message});
}

class EmptyList extends Failure {
  @override
  final String? message;
  EmptyList({this.message});
}

class ErrorSearch extends Failure {
  @override
  final String? message;
  const ErrorSearch({this.message});
}

class DatasourceResultEmpty extends Failure {
  @override
  final String? message;
  const DatasourceResultEmpty({this.message});
}
