import 'package:flutter/material.dart';

import './ui/theme/app_theme.dart';
import './ui/screens/ride_prefs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ride Share',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: RidePrefsScreen(),
    );
  }
}