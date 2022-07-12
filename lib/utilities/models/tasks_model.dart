import 'package:floor/floor.dart';

@entity
class Task {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String task;
  final String date;
  final String time;

  Task({this.id, required this.task, required this.date, required this.time});
}
