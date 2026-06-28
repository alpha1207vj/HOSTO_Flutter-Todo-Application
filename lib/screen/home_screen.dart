import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosto/cubit/task_cubit.dart';
import '../models/task_model.dart';
import '../widgets/task_card.dart';
import "package:hosto/widgets/task_modal.dart";
import "package:hosto/theme/app_colors.dart";
import "package:hosto/widgets/ui_empty.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('My Tasks',
            style: TextStyle(color: AppColors.textMain, fontSize: 24, fontWeight: FontWeight.bold)),
      ),
      // BlocBuilder listens to your TaskCubit and rebuilds whenever a new state is emitted
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } 
          
         
          
        if (state is TaskMainState) {
  final pendingTasks = state.tasks.where((t) => !t.isCompleted).toList();
  final completedTasks = state.tasks.where((t) => t.isCompleted).toList();

  return ListView(
    padding: const EdgeInsets.symmetric(vertical: 10),
    children: [
      // HEADER + LIST for Pending
      if (pendingTasks.isNotEmpty) ...[
        _buildSectionHeader("Tasks", pendingTasks.length),
        ...pendingTasks.map((task) => _buildDismissibleTask(context, task)),
      ],

      // HEADER + LIST for Completed
      if (completedTasks.isNotEmpty) ...[
        _buildSectionHeader("Completed", completedTasks.length),
        ...completedTasks.map((task) => _buildDismissibleTask(context, task)),
      ],
      
      // SHOW EMPTY STATE ONLY IF BOTH ARE EMPTY
      if (pendingTasks.isEmpty && completedTasks.isEmpty)
        buildEmptyState(), 
    ],
  );
}
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
  backgroundColor: AppColors.accentPink,
  onPressed: () async {
    // 1. Open the modal and wait for the user to submit
    final newTask = await showModalBottomSheet<TaskModel>(
      context: context,
      isScrollControlled: true,
      builder: (context) => const AddTaskModal(),
    );
    
    // 2. If the user didn't cancel (newTask is not null)
    if (newTask != null && context.mounted) {
      // 3. Call your repository via the Cubit and CAPTURE the result
      final error = await context.read<TaskCubit>().saveTask(newTask);

if (error != null && context.mounted) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Error"),
      content: Text(error),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // Closes the dialog
          child: const Text("OK"),
        ),
      ],
    ),
  );
}
    }
  },
  child: const Icon(Icons.add, color: AppColors.textMain),
),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildSectionHeader(String title, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text("$title - $count",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textMain)),
    );
  }

  Widget _buildDismissibleTask(BuildContext context, TaskModel task) {
    return Dismissible(
      // Use ID for unique keys, not title!
      key: ValueKey(task.id), 
      direction: DismissDirection.endToStart,
      background: Container(
          color: Colors.redAccent,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(Icons.delete, color: AppColors.textMain)),
      // CALL CUBIT: Deletes the task from Isar, repository notifies Cubit, UI updates
      onDismissed: (_) => context.read<TaskCubit>().deleteTask(task.id),
      child: TaskCard(
        task: task,
        // CALL CUBIT: Toggles status in Isar
        onToggle: () => context.read<TaskCubit>().toggleStatus(task.id),
      ),
    );
  }
}