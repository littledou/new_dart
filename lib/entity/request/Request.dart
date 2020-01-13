class Request {
  final String path;
  final String method;

  const Request({this.path, this.method});

  @override
  String toString() {
    return 'Request';
  }
}
