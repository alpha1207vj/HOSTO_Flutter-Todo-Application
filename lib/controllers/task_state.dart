
part of "task_cubit.dart";

sealed class TaskState extends Equatable
{
   @override
  List<Object?> get props => [];
}
final class TaskLoadingState extends TaskState
{
    TaskLoadingState();
}
final class TaskMainState extends TaskState
{
    final List<TaskModel> tasks;

    TaskMainState({
      required this.tasks
    });

    @override
  List<Object?> get props => [tasks];
}

final class TaskFailureState extends TaskState
{
  final String? message;

  TaskFailureState({
    required this.message
  });

  @override
  List<Object?> get props => [message];
}