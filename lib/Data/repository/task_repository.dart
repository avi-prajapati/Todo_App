import '../data_provider/task_db_provider.dart';
import '../model/task_model.dart';

class TaskRepository {
  final TaskDbProvider dbProvider;
  TaskRepository(this.dbProvider);

  //gettask function
  Future<List<Task>> getTasks() => dbProvider.getTasks();

  //insert task function
  Future<void> insertTask(Task task) => dbProvider.insertTask(task);

  //delete task function
  Future<void> deleteTask(int id) async {
    final db = await dbProvider.database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  //upadte task function
  Future<void> updateTask(Task task) async {
    final db = await dbProvider.database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }
}
