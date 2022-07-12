import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utilities/database/task_database.dart';
import '../../utilities/models/tasks_model.dart';
import 'states.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitialState());
  AppCubit get(context) => BlocProvider.of(context);
  TasksDatabase? _databaseInstance;
  void createDatabase() async {
    _databaseInstance ??=
        await $FloorTasksDatabase.databaseBuilder('task_database.db').build();
    emit(CreateDatabaseState());
  }

  List<Task> tasks = [];

  Future<List<Task>?> getAllTasks() async {
    if (_databaseInstance == null) {
      createDatabase();
    } else {
      final dao = _databaseInstance!.taskDao;
      tasks = await dao.getAllTasks();
      emit(GetAllTaskFormDatabaseState());
    }
    return tasks;
  }

  void insertNewTaskInDatabase(Task task) {
    if (_databaseInstance == null) {
      createDatabase();
    } else {
      final dao = _databaseInstance!.taskDao;
      dao.insertTask(task).then((_) {
        emit(InsertNewTaskFormDatabaseState());
      });
    }
  }

  void deleteTask(Task task) {
    if (_databaseInstance != null) {
      final dao = _databaseInstance!.taskDao;
      dao.removeTask(task);
      emit(DeleteTaskFormDatabaseState());
    }
  }
}
