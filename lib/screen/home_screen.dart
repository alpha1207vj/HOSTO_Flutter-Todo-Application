// lib/screen/home_screen.dart
import 'package:flutter/material.dart';
import '../models/task_model.dart'; 
import '../widgets/task_card.dart';
import "package:hosto/widgets/task_modal.dart";
import "package:hosto/theme/app_colors.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Define the 'theme' variable here first!
  final theme = Theme.of(context);
    // You can keep your list here. 
    // If you want this to change later, you will eventually need a StatefulWidget.
    final List<TaskModel> myTasks = [
      TaskModel(title: "Buy groceries"),
      TaskModel(title: "Finish Flutter project", isCompleted: true),
      TaskModel(title: "Call mom"),
      TaskModel(title: "Go to the gym"),
      TaskModel(title: "Read a book"),
      TaskModel(title: "Clean the room"),
      TaskModel(title: "Prepare presentation"),
      TaskModel(title: "Pay bills"),
      TaskModel(title: "Pbills"),
      TaskModel(title: "Hoeo"),
      TaskModel(title: "Iadd"),
      TaskModel(title: "Be reade"),
    ];

    return Scaffold(
      backgroundColor: AppColors.background, 
    
    appBar: AppBar(
      // Using your theme's primary color for the AppBar background (optional)
      backgroundColor: AppColors.background, 
      elevation: 0, // Makes it look flat and modern
      title: Text(
        'My Tasks',
        style: theme.textTheme.headlineLarge?.copyWith(
          color: AppColors.textMain, // Your theme's black/dark color
          fontSize: 24,
        ),
      ),
    ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: myTasks.length,
        itemBuilder: (context, index) {
          return TaskCard(task: myTasks[index]);
        },
),
// This adds the button in the bottom-right by default
    floatingActionButton: FloatingActionButton(
      // Use your primary color from the theme
  backgroundColor: Theme.of(context).primaryColor, 
  // Alternatively, use your specific color class:
  // backgroundColor: AppColors.accentPink,
     foregroundColor: Colors.white, // Color for the icon inside
      onPressed: () {
        showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the keyboard to push the modal up
      builder: (context) => const AddTaskModal(),
    );
      },
      child: const Icon(Icons.add),
    ),
    
    // This centers it at the bottom
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}