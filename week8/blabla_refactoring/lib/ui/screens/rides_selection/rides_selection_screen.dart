import 'package:blabla/data/repositories/ride_preferences/ride_preference_repository.dart';
import 'package:blabla/data/repositories/ride_preferences/ride_preference_repository_mock.dart';
import 'package:blabla/data/repositories/rides/ride_repository.dart';
import 'package:blabla/data/repositories/rides/ride_repository_mock.dart';
import 'package:blabla/ui/states/ride_preferences_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/ride/ride.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../services/rides_service.dart';
import '../../../utils/animations_util.dart' show AnimationUtils;
import '../../theme/theme.dart';
import 'widgets/ride_preference_modal.dart';
import 'widgets/rides_selection_header.dart';
import 'widgets/rides_selection_tile.dart';

///
///  The Ride Selection screen allows user to select a ride, once ride preferences have been defined.
///  The screen also allow user to:
///   -  re-define the ride preferences
///   -  activate some filters.
///
class RidesSelectionScreen extends StatefulWidget {
  const RidesSelectionScreen({super.key});

  @override
  State<RidesSelectionScreen> createState() => _RidesSelectionScreenState();
}

class _RidesSelectionScreenState extends State<RidesSelectionScreen> {
  final RidePreferenceRepository _ridePreferenceRepository = RidePreferenceRepositoryMock.instance;
  final RideRepository _rideRepository = RideRepositoryMock.instance;
  
  void onBackTap() {
    Navigator.pop(context);
  }

  void onFilterPressed() {
    // TODO
  }

  void onRideSelected(Ride ride) {
    // Later
  }

  RidePreference get selectedRidePreference =>
      _ridePreferenceRepository.selectedPreference!; // not null at this state

  List<Ride> get matchingRides =>
      RidesService.getRidesFor(selectedRidePreference);

  void onPreferencePressed(RidePreference currentPreference) async {
    // 1 - Navigate to the rides preference picker
    RidePreference? newPreference = await Navigator.of(context)
        .push<RidePreference>(
          AnimationUtils.createRightToLeftRoute(
            RidePreferenceModal(initialPreference: currentPreference),
          ),
        );

    if (newPreference != null) {
      // 2 - Ask the service to update the current preference
      _ridePreferenceRepository.selectPreference(newPreference);

      // 3 -   Update the widget state  - TODO Improve this with proper state managagement
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final ridePrefsState = context.watch<RidePreferencesState>();
    final selectedRidePreference = ridePrefsState.selectedPreference!;
    final matchingRides = _rideRepository.getRidesFor(selectedRidePreference);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
        child: Column(
          children: [
            RideSelectionHeader(
              ridePreference: selectedRidePreference,
              onBackPressed: onBackTap,
              onFilterPressed: onFilterPressed,
              onPreferencePressed: () => onPreferencePressed(selectedRidePreference),
            ),
        
            SizedBox(height: 100),
        
            Expanded(
              child: ListView.builder(
                itemCount: matchingRides.length,
                itemBuilder: (ctx, index) => RideSelectionTile(
                  ride: matchingRides[index],
                  onPressed: () => onRideSelected(matchingRides[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
