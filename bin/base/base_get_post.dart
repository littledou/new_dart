import 'dart:convert';
import 'dart:io';
import 'dart:async';

Future main(List<String> args) async {
  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 4042);
  print('Listening on http://${server.address.address}:${server.port}');

  await for (var request in server) {
    handleRequest(request);
  }
}

void handleRequest(HttpRequest request) async {
  print('Received request ${request.method}: ${request.uri.path}');
  if (request.method == 'GET') {
    handleGet(request);
  } else {
    await handlePost(request);
  }
  await request.response.close();
}

void handlePost(HttpRequest req) async {
  switch (req.uri.path) {
    case '/postjson'://解析json
      final content = await utf8.decoder.bind(req).join();
      var data = jsonDecode(content) as Map;
      print('content: ${content}，name: - ${data['name']}');
      
      req.response
        ..statusCode = HttpStatus.ok
        ..write('Wrote data for json.');
      break;

    case '/postform'://解析form
      req.response
        ..statusCode = HttpStatus.ok
        ..write('Wrote data for form.');
      break;

    case '/postmulti'://解析multi
      req.response
        ..statusCode = HttpStatus.ok
        ..write('Wrote data for multi.');
      break;
    default:
  }
}

void handleGet(HttpRequest req) {
  req.response
    ..statusCode = HttpStatus.ok
    ..write('Wrote data for: GET - ${req.uri.path}');
}
