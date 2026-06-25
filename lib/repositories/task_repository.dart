import "package:hosto/models/task_model.dart";


abstract class TaskRepository 
{
  Stream<List<TaskModel>> watchAllTasks();

  Future<void> saveTask(TaskModel task) ;

  Future<bool> deleteTask(int id);

  Future<void> toggleStatus(int id);

  Future<TaskModel?> getTaskById(int id);
}
