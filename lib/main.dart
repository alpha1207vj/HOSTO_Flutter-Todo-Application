import 'package:flutter/material.dart';
import 'screen/home_screen.dart'; // Import your new file here
import "package:hosto/theme/app_theme.dart";
import "package:hosto/utils/service_locator.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hosto/cubit/task_cubit.dart";
// main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // This must be awaited, otherwise the app tries to start 
  // before the locator (and Isar) is ready.
  await setupLocator(); 

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Provide the Cubit from the locator to the Widget tree
    return BlocProvider(
      create: (_) => locator<TaskCubit>()..loadAllTasks(),
      child: MaterialApp(
        theme: AppTheme.darkTheme,
        home: const HomeScreen(),
      ),
    );
  }
}