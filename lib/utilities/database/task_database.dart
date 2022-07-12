
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../dao/dao.dart';
import '../models/tasks_model.dart';

part 'task_database.g.dart';

@Database(version: 1, entities: [Task])
abstract class TasksDatabase extends FloorDatabase {
  TasksDao get taskDao;
}
