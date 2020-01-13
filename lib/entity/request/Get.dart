import 'package:dart_hello_server/entity/request/Request.dart';

class Get extends Request {
  final String path;

  const Get(this.path) : super(path: path, method: 'GET');

  @override
  String toString() {
    return 'GET';
  }
}
