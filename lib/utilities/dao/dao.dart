import '../models/tasks_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class TasksDao {
  @Query("SELECT * FROM Task")
  Future<List<Task>> getAllTasks();

  @insert
  Future<void> insertTask(Task newTask);

  @delete
  Future<void> removeTask(Task task);
}
