import "package:hosto/models/task_model.dart";


abstract class TaskRepository 
{
  Stream<List<TaskModel>> watchAllTasks();

  Future<String?> saveTask(TaskModel task) ;

  Future<String?> deleteTask(int id);

  Future<String?> toggleStatus(int id);

  Future<TaskModel?> getTaskById(int id);
}
