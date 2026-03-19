import 'package:blabla/data/repositories/ride_preferences/ride_preference_repository.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';

class RidePreferenceRepositoryMock implements RidePreferenceRepository{
  RidePreferenceRepositoryMock._();

  static final RidePreferenceRepositoryMock instance = RidePreferenceRepositoryMock._();

  RidePreference? _selectedPreference;
  final List<RidePreference> _history = [];
  
  @override
  int get maxAllowedSeats => 8;

  @override
  RidePreference? get selectedPreference => _selectedPreference;

  @override
  List<RidePreference> get preferenceHistory => List.unmodifiable(_history);
  
  @override
  void selectPreference(RidePreference preference) {
    if (preference == _selectedPreference) return;
    _selectedPreference = preference;
    _history.add(preference);
  }
}