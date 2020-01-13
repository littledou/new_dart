import 'dart:async';
import 'dart:io';
import 'package:http_server/http_server.dart';
import 'package:path/path.dart' as p;

var targetFile = File(p.join(p.dirname(Platform.script.toFilePath()), 'index.html'));

Future main() async {
  var staticFiles = VirtualDirectory('.');

  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 4046);
  print('file Listening on http://${server.address.address}:${server.port}/');
  await for (var request in server) {
    staticFiles.serveFile(targetFile, request);
  }
}
