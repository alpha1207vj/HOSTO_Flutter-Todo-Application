import 'package:flutter/material.dart';
import 'package:hosto/models/task_model.dart';
import 'package:hosto/theme/app_colors.dart';
import 'package:hosto/widgets/task_detail_screen.dart';

class TaskCard extends StatelessWidget { // Change to StatelessWidget
  final TaskModel task;
  final VoidCallback onToggle;

  const TaskCard({super.key, required this.task, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final date = task.date ?? DateTime.now();
    String formattedDate = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

    return Card(
      color: AppColors.taskBackground,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskDetailScreen(task: task)),
          );
        },
        title: Text(
          task.title,
          style: theme.textTheme.headlineLarge?.copyWith(
            fontSize: 18,
            decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
            color: task.isCompleted ? AppColors.textMutedColor : AppColors.textMain,
          ),
        ),
        subtitle: Text(formattedDate, style: theme.textTheme.bodyMedium),
        leading: IconButton(
          iconSize: 24,
          onPressed: onToggle, // Simply call the passed callback
          icon: Icon(
            task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: theme.primaryColor,
          ),
        ),
      ),
    );
  }
}