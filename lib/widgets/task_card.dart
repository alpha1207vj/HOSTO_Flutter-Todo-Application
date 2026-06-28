import 'package:flutter/material.dart';
import 'package:hosto/models/task_model.dart';
import 'package:hosto/theme/app_colors.dart';
import 'package:hosto/widgets/task_detail_screen.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Safety check for null date (using DateTime.now() if date is missing)
    final date = task.date ?? DateTime.now();
    String formattedDate = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

    return Card(
      color: AppColors.background,
      child: ListTile(
        // Moving the navigation here makes the whole card clickable
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailScreen(task: task),
            ),
          );
        },
        title: Text(
          task.title,
          style: theme.textTheme.headlineLarge?.copyWith(fontSize: 18),
        ),
        subtitle: Text(
          formattedDate,
          style: theme.textTheme.bodyMedium,
        ),
        leading: Icon(
          task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: theme.primaryColor,
        ),
      ),
    );
  }
}