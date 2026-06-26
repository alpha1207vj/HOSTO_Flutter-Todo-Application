import "dart:async";

import "package:hosto/cubit/task_cubit.dart";
import "package:mocktail/mocktail.dart";
import "package:hosto/repositories/task_repository.dart";
import "package:flutter_test/flutter_test.dart";
import "package:bloc_test/bloc_test.dart";
import "package:hosto/models/task_model.dart";

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  registerFallbackValue(TaskModel(title: "mydate"));

  late TaskCubit taskCubit;
  late MockTaskRepository mockTaskRepository;
  late StreamController<List<TaskModel>> streamController;

  setUp(() async {
    streamController = StreamController<List<TaskModel>>();
    mockTaskRepository = MockTaskRepository();
    taskCubit = TaskCubit(mockTaskRepository);
  });

  tearDown(() async {
    streamController.close();
    taskCubit.close();
  });

  group('Tasks Features Tests', () {

    blocTest<TaskCubit, TaskState>(
      "Verify SaveTask Success",
      build: () {
        when(() => mockTaskRepository.saveTask(any()))
            .thenAnswer((_) async => Future<String?>.value(null));
        return taskCubit;
      },
      act: (cubit) {
        final myTask = TaskModel(title: "My task is ready");
        cubit.saveTask(myTask);
      },
      expect: () => [],
      verify: (_) {
        verify(() => mockTaskRepository.saveTask(any())).called(1);
      },
    );

    blocTest<TaskCubit, TaskState>(
      "Verify SaveTask Fail",
      build: () {
        when(() => mockTaskRepository.saveTask(any()))
            .thenThrow(Exception("Failed to save task:No title entered"));
        return taskCubit;
      },
      act: (cubit) {
        final myTask = TaskModel(title: "");
        cubit.saveTask(myTask);
      },
      expect: () => [
        TaskFailureState(message: "Exception: Failed to save task:No title entered"),
      ],
      verify: (_) {
        verify(() => mockTaskRepository.saveTask(any())).called(1);
      },
    );

    blocTest(
      "Verify DeleteTask Success",
      build: () {
        when(() => mockTaskRepository.saveTask(any()))
            .thenAnswer((_) async => null);
        when(() => mockTaskRepository.deleteTask(any()))
            .thenAnswer((_) async => null);
        return taskCubit;
      },
      act: (cubit) {
        final myTask = TaskModel(title: "My task is ready");
        cubit.saveTask(myTask);
        cubit.deleteTask(myTask.id);
      },
      expect: () => [],
      verify: (_) {
        verify(() => mockTaskRepository.saveTask(any())).called(1);
        verify(() => mockTaskRepository.deleteTask(any())).called(1);
      },
    );

    blocTest(
      "Verify DeleteTask Fail",
      build: () {
        when(() => mockTaskRepository.saveTask(any()))
            .thenAnswer((_) async => null);
        when(() => mockTaskRepository.deleteTask(any()))
            .thenThrow(Exception("Database Failure"));
        return taskCubit;
      },
      act: (cubit) {
        final myTask = TaskModel(title: "My task is ready");
        cubit.saveTask(myTask);
        cubit.deleteTask(myTask.id);
      },
      expect: () => [
        TaskFailureState(message: "Exception: Database Failure"),
      ],
      verify: (_) {
        verify(() => mockTaskRepository.saveTask(any())).called(1);
        verify(() => mockTaskRepository.deleteTask(any())).called(1);
      },
    );

    blocTest(
      "Verify ToggleStatus Success",
      build: () {
        when(() => mockTaskRepository.saveTask(any()))
            .thenAnswer((_) async => null);
        when(() => mockTaskRepository.toggleStatus(any()))
            .thenAnswer((_) async => null);
        return taskCubit;
      },
      act: (cubit) {
        final myTask = TaskModel(title: "My task is ready");
        cubit.saveTask(myTask);
        cubit.toggleStatus(myTask.id);
      },
      expect: () => [],
      verify: (_) {
        verify(() => mockTaskRepository.saveTask(any())).called(1);
        verify(() => mockTaskRepository.toggleStatus(any())).called(1);
      },
    );

    blocTest(
      "Verify ToggleStatus Fail",
      build: () {
        when(() => mockTaskRepository.saveTask(any()))
            .thenAnswer((_) async => null);
        when(() => mockTaskRepository.toggleStatus(any()))
            .thenThrow(Exception("Database Failure"));
        return taskCubit;
      },
      act: (cubit) {
        final myTask = TaskModel(title: "My task is ready");
        cubit.saveTask(myTask);
        cubit.toggleStatus(myTask.id);
      },
      expect: () => [
        TaskFailureState(message: "Exception: Database Failure"),
      ],
      verify: (_) {
        verify(() => mockTaskRepository.saveTask(any())).called(1);
        verify(() => mockTaskRepository.toggleStatus(any())).called(1);
      },
    );

    blocTest(
      "Verify GetTaskById Success",
      build: () {
        when(() => mockTaskRepository.saveTask(any()))
            .thenAnswer((_) async => null);
        when(() => mockTaskRepository.getTaskById(any()))
            .thenAnswer((_) async => Future<TaskModel?>.value());
        return taskCubit;
      },
      act: (cubit) {
        final myTask = TaskModel(title: "My task is ready");
        cubit.saveTask(myTask);
        cubit.getTaskById(myTask.id);
      },
      expect: () => [],
      verify: (_) {
        verify(() => mockTaskRepository.saveTask(any())).called(1);
        verify(() => mockTaskRepository.getTaskById(any())).called(1);
      },
    );

    blocTest(
      "Verify GetTaskById Failure",
      build: () {
        when(() => mockTaskRepository.saveTask(any()))
            .thenAnswer((_) async => null);
        when(() => mockTaskRepository.getTaskById(any()))
            .thenThrow(Exception("Database Failure"));
        return taskCubit;
      },
      act: (cubit) {
        final myTask = TaskModel(title: "My task is ready");
        cubit.saveTask(myTask);
        cubit.getTaskById(myTask.id);
      },
      expect: () => [
        TaskFailureState(message: "Exception: Database Failure"),
      ],
      verify: (_) {
        verify(() => mockTaskRepository.saveTask(any())).called(1);
        verify(() => mockTaskRepository.getTaskById(any())).called(1);
      },
    );

    blocTest(
      "Verify WatchAllTasks Success",
      build: () {
        when(() => mockTaskRepository.watchAllTasks())
            .thenAnswer((_) => streamController.stream);
        return taskCubit;
      },
      act: (cubit) {
        cubit.loadAllTasks();
        streamController.add([TaskModel(title: "Task 1")]);
        streamController.add([TaskModel(title: "Task 1"), TaskModel(title: "Task 2")]);
      },
      expect: () => [
        TaskLoadingState(),
        TaskMainState(tasks: [TaskModel(title: "Task 1")]),
        TaskMainState(tasks: [TaskModel(title: "Task 1"), TaskModel(title: "Task 2")]),
      ],
      verify: (_) {
        verify(() => mockTaskRepository.watchAllTasks()).called(1);
      },
    );

    blocTest(
      "Verify WatchAllTasks Failure",
      build: () {
        when(() => mockTaskRepository.watchAllTasks())
            .thenAnswer((_) => streamController.stream);
        return taskCubit;
      },
      act: (cubit) {
        cubit.loadAllTasks();
        streamController.addError(Exception("Database Failure"));
      },
      expect: () => [
        TaskLoadingState(),
        TaskFailureState(message: "Exception: Database Failure"),
      ],
      verify: (_) {
        verify(() => mockTaskRepository.watchAllTasks()).called(1);
      },
    );

  });
}