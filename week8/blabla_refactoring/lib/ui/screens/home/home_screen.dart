import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:blabla/ui/states/ride_preferences_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/animations_util.dart';
import '../../theme/theme.dart';
import '../../widgets/pickers/bla_ride_preference_picker.dart';
import '../rides_selection/rides_selection_screen.dart';
import 'widgets/home_history_tile.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

///
/// This screen allows user to:
/// - Enter his/her ride preference and launch a search on it
/// - Or select a last entered ride preferences and launch a search on it
///
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> onRidePrefSelected(BuildContext context, RidePreference selectedPreference) async {
    // 1- Ask the state to update the current preference
    context.read<RidePreferencesState>().selectPreference(selectedPreference);

    // 2 - Navigate to the rides screen
    await Navigator.of(
      context,
    ).push(AnimationUtils.createBottomToTopRoute(RidesSelectionScreen()));

  }

  @override
  Widget build(BuildContext context) {
    final ridePrefsState = context.watch<RidePreferencesState>();

    return Stack(children: [_buildBackground(), _buildForeground(context, ridePrefsState)]);
  }

  Widget _buildForeground(BuildContext context, RidePreferencesState ridePrefsState) {
    return Column(
      children: [
        // 1 - THE HEADER
        SizedBox(height: 16),
        Align(
          alignment: AlignmentGeometry.center,
          child: Text(
            "Your pick of rides at low price",
            style: BlaTextStyles.heading.copyWith(color: Colors.white),
          ),
        ),
        SizedBox(height: 100),

        Container(
          margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
          decoration: BoxDecoration(
            color: Colors.white, // White background
            borderRadius: BorderRadius.circular(16), // Rounded corners
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 2 - THE FORM
              BlaRidePreferencePicker(
                initRidePreference: ridePrefsState.selectedPreference,
                onRidePreferenceSelected: (pref) => onRidePrefSelected(context, pref),
              ),
              SizedBox(height: BlaSpacings.m),

              // 3 - THE HISTORY
              _buildHistory(context, ridePrefsState),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistory(BuildContext context, RidePreferencesState ridePrefsState) {

    // Reverse the history of preferences
    List<RidePreference> history = ridePrefsState.history.reversed
        .toList();
    return SizedBox(
      height: 200, // Set a fixed height
      child: ListView.builder(
        shrinkWrap: true, // Fix ListView height issue
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: history.length,
        itemBuilder: (ctx, index) => HomeHistoryTile(
          ridePref: history[index],
          onPressed: () => onRidePrefSelected(context, history[index]),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover, // Adjust image fit to cover the container
      ),
    );
  }
}
