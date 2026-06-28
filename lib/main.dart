import 'package:flutter/material.dart';
import 'screen/home_screen.dart'; // Import your new file here
import "package:hosto/theme/app_theme.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hosto',
      // Assuming you already linked your theme here:
       theme: AppTheme.darkTheme, 
      
      // THIS is where you put your home screen:
      home: const HomeScreen(), 
    );
  }
}