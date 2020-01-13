import 'package:dart_hello_server/entity/request/Request.dart';

class Post extends Request{
  final String path;

  const Post({this.path}) : super(path : path, method: 'POST');

  @override
  String toString() =>'Get';

}