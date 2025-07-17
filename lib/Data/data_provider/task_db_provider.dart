import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/task_model.dart';

class TaskDbProvider {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await init();
    return _database!;
  }

  //Creating table
  Future<Database> init() async {
    final path = join(await getDatabasesPath(), 'task_database.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, category TEXT, date TEXT, priority INTEGER, isCompleted INTEGER)',
        );
      },
    );
    return _database!;
  }

  //to get tasks
  Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      orderBy: 'isCompleted ASC, priority ASC',
    );

    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  //to insert task in table
  Future<void> insertTask(Task task) async {
    final db = _database!;
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //to delete task
  Future<void> deleteTask(int id) async {
    final db = _database!;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
