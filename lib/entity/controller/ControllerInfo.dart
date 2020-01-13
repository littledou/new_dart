import 'dart:io';
import 'dart:mirrors';

class ControllerInfo {
  final Map<String, Symbol> urlToMethod;

  final InstanceMirror instanceMirror;

  ControllerInfo(this.instanceMirror, this.urlToMethod);

  void invoke(String url, String method, HttpRequest request) {
    if (urlToMethod.containsKey('$url#$method')) {
      instanceMirror.invoke(urlToMethod['$url#$method'], [request]);
    } else {
      request.response
        ..statusCode = HttpStatus.methodNotAllowed
        ..write('''{
        "code": 405,
        "msg": “请求出错”
      }''');
    }
  }
}
