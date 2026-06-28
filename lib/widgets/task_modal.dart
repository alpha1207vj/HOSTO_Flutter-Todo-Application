import 'package:flutter/material.dart';

class AddTaskModal extends StatelessWidget {
  const AddTaskModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Takes only the space needed
        children: [
          const Text("New Task", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const TextField(decoration: InputDecoration(labelText: "Title")),
          const TextField(decoration: InputDecoration(labelText: "Description")),
          const SizedBox(height: 100),
          ElevatedButton(
            onPressed: () => Navigator.pop(context), // Closes the popup
            child: const Text("Save Task"),
          ),
        ],
      ),
    );
  }
}