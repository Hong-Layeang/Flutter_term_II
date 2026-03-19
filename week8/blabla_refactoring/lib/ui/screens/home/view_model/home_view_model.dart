import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:blabla/ui/states/ride_preferences_state.dart';
import 'package:flutter/material.dart';

import '../../../../utils/animations_util.dart';
import '../../rides_selection/rides_selection_screen.dart';

class HomeViewModel extends ChangeNotifier {
  final RidePreferencesState ridePreferencesState;

  HomeViewModel({required this.ridePreferencesState}) {
    ridePreferencesState.addListener(notifyListeners);
  }

  @override
  void dispose() {
    ridePreferencesState.removeListener(notifyListeners);
    super.dispose();
  }

  RidePreference? get selectedPreference => ridePreferencesState.selectedPreference;

  List<RidePreference> get history => ridePreferencesState.history.reversed.toList();

  Future<void> onRidePreferenceSelected(BuildContext context, RidePreference selectedPreference) async {
    ridePreferencesState.selectPreference(selectedPreference);

    await Navigator.of(context).push(
      AnimationUtils.createBottomToTopRoute(const RidesSelectionScreen()),
    );
  }
}
