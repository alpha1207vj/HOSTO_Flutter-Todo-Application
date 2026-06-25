import "package:hosto/repositories/task_repository.dart";
import "package:hosto/models/task_model.dart";
import "package:isar_community/isar.dart";


class TaskRepositoryImpl extends TaskRepository
{
  final Isar isar;
  TaskRepositoryImpl({
    required this.isar
  });

  @override 
  Stream<List<TaskModel>> watchAllTasks()
  {
    return isar.taskModels.where().watch(fireImmediately : true);
  }

  @override 
  Future<void> saveTask(TaskModel task) async 
  {
     await isar.taskModels.put(task);
  }

  @override
  Future<bool> deleteTask(int id) async
  {
    return await isar.writeTxn(()async
    {
      return await isar.taskModels.delete(id);
    });
  }

  @override 
  Future<TaskModel?> getTaskById(int id) async 
  {
    return await isar.taskModels.get(id);
  }

  @override 
  Future<bool> toggleStatus(int id) async 
  {
    return await isar.writeTxn(()async
    {
     final specificTask = await isar.taskModels.get(id);
     if(specificTask == null) return false;
     specificTask.isCompleted = !specificTask.isCompleted;
     await isar.taskModels.put(specificTask);
     return true;
    });
  }
}