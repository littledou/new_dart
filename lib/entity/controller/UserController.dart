import 'dart:io';

import 'package:dart_hello_server/entity/controller/BaseController.dart';
import 'package:dart_hello_server/entity/controller/Controller.dart';
import 'package:dart_hello_server/entity/request/Get.dart';
import 'package:dart_hello_server/entity/request/Post.dart';
import 'package:dart_hello_server/entity/request/Request.dart';

@Controller(path: '/user')
class UserController extends BaseController {
  @Get(path: '/login')
  void login(HttpRequest request) {
    request.response
      ..statusCode = HttpStatus.ok
      ..writeln('Login Success')
      ..close();
  }

  @Post(path: '/logout')
  void logout(HttpRequest request) {
    request.response
      ..statusCode = HttpStatus.ok
      ..writeln('logoutSuccess')
      ..close();
  }

  @Request(path: '/delete', method: 'DELETE')
  void editUser(HttpRequest request) {
    request.response
      ..statusCode = HttpStatus.ok
      ..writeln('DeleteSuccess')
      ..close();
  }
}
