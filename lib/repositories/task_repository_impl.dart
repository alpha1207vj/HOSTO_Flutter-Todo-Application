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
  Future<String?> saveTask(TaskModel task) async 
  {
      if(task.title.trim().isEmpty)
        {
          return "Failed to save task:No title entered";
        }
      try
      {
         await isar.writeTxn(() 
      async {
      
        await isar.taskModels.put(task);
      });
      return null ;
      }
      catch(e)
      {
        return "Failed to save task: ${e.toString()}";
      }
     
  }

  @override
  Future<String?> deleteTask(int id) async
  {
    try
    {
       return await isar.writeTxn(()async
    {
      final isDeleted =  await isar.taskModels.delete(id);
      if(isDeleted)
      {
        return null;
      }
      else 
      {
        return "Failed to delete task";
      }
    });
    }
    catch(e)
    {
      return "Failed to delete task: ${e.toString()}";
    }
  }

  @override 
  Future<TaskModel?> getTaskById(int id) async 
  {
    final myTask = await isar.taskModels.get(id);

    if (myTask != null) {
     return myTask;
}   else {
     return null;
}
    
  }

  @override 
  Future<String?> toggleStatus(int id) async 
  {
    try{
       return await isar.writeTxn(()async
    {
     final specificTask = await isar.taskModels.get(id);
     if(specificTask == null) 
     {
      return "Error changing task status" ;
     }
     else
     {
      specificTask.isCompleted = !specificTask.isCompleted;
      await isar.taskModels.put(specificTask);
      return null;
     }
    });
    }
    catch(e)
    {
      return "Error changing task status: ${e.toString()}";
    }
   
  }
}