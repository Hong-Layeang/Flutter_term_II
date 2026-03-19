import 'package:blabla/data/repositories/rides/ride_repository.dart';
import 'package:blabla/model/ride/ride.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:blabla/ui/states/ride_preferences_state.dart';
import 'package:flutter/material.dart';

class RidesSelectionViewModel extends ChangeNotifier {
  final RideRepository rideRepository;
  final RidePreferencesState ridePreferencesState;

  RidesSelectionViewModel({
    required this.rideRepository,
    required this.ridePreferencesState,
  }) {
    ridePreferencesState.addListener(notifyListeners);
  }

  @override
  void dispose() {
    ridePreferencesState.removeListener(notifyListeners);
    super.dispose();
  }

  RidePreference? get selectedPreference => ridePreferencesState.selectedPreference;

  List<Ride> get matchingRides {
    final RidePreference? preference = selectedPreference;
    if (preference == null) return [];
    return rideRepository.getRidesFor(preference);
  }

  void selectPreference(RidePreference preference) {
    ridePreferencesState.selectPreference(preference);
  }

  void onRideSelected(Ride ride) {
    // Later
  }

  void onFilterPressed() {
    // Later
  }
}
