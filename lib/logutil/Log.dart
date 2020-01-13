
import 'dart:io';

void writeLog(String log) async{
  var date = DateTime.now();
  var year = date.year;
  var month = date.month;
  var day = date.day;
  var directory = await Directory('./log/$year-$month-$day').create(recursive: true);

  var file = File('${directory.path}/${date.hour}:${date.minute}.log');

  await file.exists().then((isexists){
    var logaddtime = '\n\ntime:${date.toIso8601String()}\n$log';
    file.writeAsString(logaddtime, mode: FileMode.append);
  });
}