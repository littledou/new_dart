import 'package:jaguar/serve/server.dart';

main() async {
  var server = Jaguar(port: 4040);
  final quotes = <String>[
    'But man is not made for defeat. A man can be destroyed but not defeated.',
    'When you reach the end of your rope, tie a knot in it and hang on.',
    'Learning never exhausts the mind.',
  ];

  server.get('/api/quote/:index', (ctx) {
    // The magic!
    final index = ctx.pathParams.getInt('index', 1); // The magic!
    print('index: $index');
    return quotes[index];
  });
  await server.serve();
}
