// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorTasksDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$TasksDatabaseBuilder databaseBuilder(String name) =>
      _$TasksDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$TasksDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$TasksDatabaseBuilder(null);
}

class _$TasksDatabaseBuilder {
  _$TasksDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$TasksDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$TasksDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<TasksDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$TasksDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$TasksDatabase extends TasksDatabase {
  _$TasksDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TasksDao? _taskDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Task` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `task` TEXT NOT NULL, `date` TEXT NOT NULL, `time` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TasksDao get taskDao {
    return _taskDaoInstance ??= _$TasksDao(database, changeListener);
  }
}

class _$TasksDao extends TasksDao {
  _$TasksDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _taskInsertionAdapter = InsertionAdapter(
            database,
            'Task',
            (Task item) => <String, Object?>{
                  'id': item.id,
                  'task': item.task,
                  'date': item.date,
                  'time': item.time
                }),
        _taskDeletionAdapter = DeletionAdapter(
            database,
            'Task',
            ['id'],
            (Task item) => <String, Object?>{
                  'id': item.id,
                  'task': item.task,
                  'date': item.date,
                  'time': item.time
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Task> _taskInsertionAdapter;

  final DeletionAdapter<Task> _taskDeletionAdapter;

  @override
  Future<List<Task>> getAllTasks() async {
    return _queryAdapter.queryList('SELECT * FROM Task',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            task: row['task'] as String,
            date: row['date'] as String,
            time: row['time'] as String));
  }

  @override
  Future<void> insertTask(Task newTask) async {
    await _taskInsertionAdapter.insert(newTask, OnConflictStrategy.abort);
  }

  @override
  Future<void> removeTask(Task task) async {
    await _taskDeletionAdapter.delete(task);
  }
}
