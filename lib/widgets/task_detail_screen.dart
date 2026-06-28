import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskModel task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(title: const Text("Task Details")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title", style: theme.textTheme.bodySmall),
            Text(task.title, style: theme.textTheme.headlineLarge),
            const Divider(),
            const SizedBox(height: 10),
            Text("Status", style: theme.textTheme.bodySmall),
            Chip(
              label: Text(task.isCompleted ? "Completed" : "Pending"),
              backgroundColor: task.isCompleted ? Colors.green[100] : Colors.orange[100],
            ),
            const SizedBox(height: 20),
            Text("Description", style: theme.textTheme.bodySmall),
            const SizedBox(height: 5),
            Text(task.description ?? "No description provided.", 
                 style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}