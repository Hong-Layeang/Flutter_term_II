
import 'package:blabla/data/repositories/ride_preferences/ride_preference_repository_mock.dart';
import 'package:blabla/ui/states/ride_preferences_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/screens/home/home_screen.dart';
import 'ui/theme/theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => RidePreferencesState(
        repository: RidePreferenceRepositoryMock.instance
      ),
      child: const BlaBlaApp()
    )
  ); 
}


class BlaBlaApp extends StatelessWidget {
  const BlaBlaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: blaTheme,
      home: Scaffold(body: HomeScreen()),
    );
  }
}
