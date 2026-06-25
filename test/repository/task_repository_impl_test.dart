import "package:flutter_test/flutter_test.dart";
import "package:hosto/models/task_model.dart";
import "package:hosto/repositories/task_repository_impl.dart";
import "package:get_it/get_it.dart";
import "package:path_provider/path_provider.dart";
import "package:isar_community/isar.dart";

void main()
{
  late Isar isar;
  late TaskRepositoryImpl repositoryImpl;

  setUp(() async {
  isar = await Isar.open([TaskModelSchema], directory: '',name: "test_db");

  repositoryImpl = TaskRepositoryImpl(isar: isar);
});

tearDown(() async {
  await isar.close(deleteFromDisk: true);
});

group('Tasks Features Tests', () {
  
  test('Check Task Save', () 
  {

  });
  test('Check Task Save Fail', () 
  {

  });
});
}