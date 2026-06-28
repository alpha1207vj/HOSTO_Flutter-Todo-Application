import "dart:async";

import "package:equatable/equatable.dart";
import "package:hosto/models/task_model.dart";
import "package:hosto/repositories/task_repository.dart";
import "package:flutter_bloc/flutter_bloc.dart";

part "task_state.dart";

class TaskCubit extends Cubit<TaskState>
{
  final TaskRepository repository;
  
  StreamSubscription<List<TaskModel>>? newStreamSubscription;

  TaskCubit(this.repository) : super(TaskLoadingState());

  void loadAllTasks()
  {
    emit(TaskLoadingState());
    
    newStreamSubscription = repository.watchAllTasks().listen((uiTasks)
    {
     emit(TaskMainState(tasks: uiTasks)); 
    },
    onError: (error)
    {
     emit(TaskFailureState(message: error.toString()));
    }    
    );
  }

 Future<String?> saveTask(TaskModel task) async {
  try {
    // 1. Capture the result from the repo
    final String? error = await repository.saveTask(task);
    
    // 2. If there is an error, emit the failure state
    if (error != null) {
      emit(TaskFailureState(message: error));
    }
    
    // 3. RETURN the error so the UI can use it
    return error; 
    
  } catch (e) {
    final errorMessage = e.toString();
    emit(TaskFailureState(message: errorMessage));
    // 4. Return the caught error
    return errorMessage; 
  }
}

  Future<void> deleteTask(int id)
  async {
    try
    {
      await repository.deleteTask(id);

    }
    catch(e)
    {
      emit(TaskFailureState(message: e.toString()));
    }
  }

  Future<void> toggleStatus(int id)
  async {
   
    try
    {
      await repository.toggleStatus(id);
    }
    catch(e)
    {
      emit(TaskFailureState(message: e.toString()));
    }
  }

  Future<void> getTaskById(int id)
  async{
    try
    {
      await repository.getTaskById(id);
    }
    catch(e)
    {
      emit(TaskFailureState(message: e.toString()));
    }
  }

  @override
  Future<void> close()
  async {
    newStreamSubscription?.cancel();
    super.close();
  }
}