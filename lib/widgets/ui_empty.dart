import 'package:flutter/material.dart';
import "package:hosto/theme/app_colors.dart";
Widget buildEmptyState() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 220),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Using an icon as the "figure"
        Icon(Icons.inventory_2_outlined, size: 80, color: AppColors.textMutedColor),
        SizedBox(height: 16),
        Text(
          "Your list is empty",
          style: TextStyle(fontSize: 20, color: AppColors.textMutedColor),
        ),
      ],
    ),
  );
}