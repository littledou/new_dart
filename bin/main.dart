import 'package:dart_hello_server/log/Log.dart';
import 'dart:io';
import 'package:http_server/http_server.dart';
import 'package:path/path.dart' as p;

var webFile =
    File(p.dirname(p.dirname(Platform.script.toFilePath())) + '/webApp');

Future main() async {
  print('${webFile.path}');
  
  //获取webApp根目录
  var staticFiles = VirtualDirectory(webFile.path);
  //允许目录监听
  staticFiles.allowDirectoryListing = true;
  //处理访问根目录
  staticFiles.directoryHandler = (dir, request) {
    var indexUrl = Uri.file(dir.path).resolve('index.html');
    staticFiles.serveFile(File(indexUrl.toFilePath()), request);
  };

  //处理访问不存在的目录
  staticFiles.errorPageHandler = (request) {
    if (request.uri.pathSegments.last.contains('html')) {
      staticFiles.serveFile(File(p.join(webFile.path, '404.html')), request);
    } else {
      handleRequest(request);
    }
  };

  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 4040);
  print('main Listening on http://${server.address.address}:${server.port}/');
  await for (var request in server) {
    writeHeaders(request);
    await staticFiles.serveRequest(request);
  }
}

void handleRequest(HttpRequest request) async {
  print(
      'Received request ${request.method}: ${request.uri.path} , ${request.uri.toString()}');
  if (request.method == 'GET') {
    handleGet(request);
  }
  await request.response.close();
}

void handleGet(HttpRequest request) {
  request.response
    ..statusCode = HttpStatus.ok
    ..write('Wrote data for: GET - ${request.uri.path}');
}

void writeHeaders(HttpRequest request) {
  var headers = <String>[];
  request.headers.forEach((key, values) {
    var header = '${key}: ';
    for (var value in values) {
      header += '$value , ';
    }
    headers.add(header);
  });

  writeLog('${headers.join('\n')}');
}
