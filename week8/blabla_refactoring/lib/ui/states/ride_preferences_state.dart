import 'package:blabla/data/repositories/ride_preferences/ride_preference_repository.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:flutter/material.dart';

class RidePreferencesState extends ChangeNotifier {
 final RidePreferenceRepository repository;

 RidePreferencesState({required this.repository});

 RidePreference? get selectedPreference => repository.selectedPreference;
 List<RidePreference> get history => repository.preferenceHistory.reversed.toList();
 int get maxAllowedSeats => repository.maxAllowedSeats;

 void selectPreference(RidePreference preference) {
  repository.selectPreference(preference);
  notifyListeners();
 }
}