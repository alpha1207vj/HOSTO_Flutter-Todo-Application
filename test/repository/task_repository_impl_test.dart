import "package:flutter_test/flutter_test.dart";
import "package:hosto/models/task_model.dart";
import "package:hosto/repositories/task_repository_impl.dart";
import "package:isar_community/isar.dart";
import "package:get_it/get_it.dart";
import "package:isar_community_flutter_libs/isar_flutter_libs.dart";



void main()
{
  late Isar isar;
  late TaskRepositoryImpl repositoryImpl;
  late GetIt locator = GetIt.instance;

  setUp(() async {
    await Isar.initializeIsarCore(download: true);
    isar = await Isar.open([TaskModelSchema], directory: '',name: "test_db");
    locator.registerSingleton<Isar>(isar);
    repositoryImpl = TaskRepositoryImpl(isar: isar);
});

tearDown(() async {
  await isar.close(deleteFromDisk: true);
   await locator.reset();
});

group('Tasks Features Tests', () {
  
  test('Check Task Save', () 
    async {
    // Arrange 
    final myTask = TaskModel(title: "My task is ready", isCompleted: false);
  
    // Act 
    final result  = await repositoryImpl.saveTask(myTask);

    // Assert
    expect(result,null);
  });
  test('Check Task Save Fail', () 
    async {
     // Arrange 
    final myTask = TaskModel(title: "", isCompleted: false);
  
    // Act 
    final result  = await repositoryImpl.saveTask(myTask);

    // Assert
    expect(result,startsWith("Failed to save task"));
  });


  test("Check Continuous Stream",()
    async
    {
      //Arrange 
      final myTask1 = TaskModel(title: "My task is ready", isCompleted: false);
      final myTask2 = TaskModel(title: "My task is not reade", isCompleted: false);
     
      //Act
      final stream = repositoryImpl.watchAllTasks();
      final expectStream = expectLater(
      stream, 
      emitsInOrder([
        [],
        predicate<List<TaskModel>>((list)=> list.length ==1),
        predicate<List<TaskModel>>((list)=> list.length ==2)
      ]));
      await repositoryImpl.saveTask(myTask1);
      await repositoryImpl.saveTask(myTask2);

      //Assert
      await expectStream;
    });
  test("Check Continuous Stream Fail",()
    async
    {
      //Act
      final stream = repositoryImpl.watchAllTasks();

      await expectLater(stream, 
      emits(predicate<List<TaskModel>>((list)=>list.isEmpty)));
    });


  test('Check Task GetTaskById',()
    async
  {
    //Arrange
     final myTask = TaskModel(title: "my new test",isCompleted: false);
     await repositoryImpl.saveTask(myTask);

    //Act
    final result = await repositoryImpl.getTaskById(myTask.id);

    //Assert
    expect(result,myTask);
  });
  test('Check Task GetTaskById Fail',()
   async
  {
    //Arrange
     final myTask = TaskModel(title: "my new test",isCompleted: false);
     await repositoryImpl.saveTask(myTask);

    //Act
    final result = await repositoryImpl.getTaskById(myTask.id + 1);

    //Assert
    expect(result,null);
  });


  test('Check Toggle StatusTask',()
   async
   {
     //Arrange
     final myTask = TaskModel(title: "My task is ready", isCompleted: false);
     await repositoryImpl.saveTask(myTask);

     //Act
     final result = await repositoryImpl.toggleStatus(myTask.id);

     //Assert
     expect(result,null);
   }); 
  test('Check Toggle StatusTask Fail',()async
   {
     //Arrange
     final myTask = TaskModel(title: "My task is ready", isCompleted: false);
     await repositoryImpl.saveTask(myTask);

     //Act
     final result = await repositoryImpl.toggleStatus(myTask.id + 1);

     //Assert
     expect(result,startsWith("Error changing task status"));
   }); 


  test("Check DeleteTaskById",()
    async
    {
      //Arrange 
        final myTask = TaskModel(title: "My task is ready", isCompleted: false);
        await repositoryImpl.saveTask(myTask);
      
      //Act
        final result = await repositoryImpl.deleteTask(myTask.id);
      
      //Assert
      expect(result,null);

    });
  test("Check DeleteTaskById Fail",()
    async
    {
      //Arrange 
        final myTask = TaskModel(title: "My task is ready", isCompleted: false);
        await repositoryImpl.saveTask(myTask);
      
      //Act
        final result = await repositoryImpl.deleteTask(myTask.id + 1);
      
      //Assert
      expect(result,startsWith("Failed to delete task"));
    });
});

 
}