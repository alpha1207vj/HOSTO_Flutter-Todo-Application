import "package:isar_community/isar.dart";
import "package:path_provider/path_provider.dart";
import "package:get_it/get_it.dart";
import "package:hosto/repositories/task_repository.dart";
import "package:hosto/repositories/task_repository_impl.dart";
import 'package:hosto/models/task_model.dart';


final GetIt locator = GetIt.instance();

Future<void> setupLocator() async
{
 final dir  = await getApplicationDocumentsDirectory();
 final isar = await Isar.open([TaskModelSchema], directory: dir.path );
 locator.registerSingleton<Isar>(isar);

   locator.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(isar : locator<Isar>())
  );

}