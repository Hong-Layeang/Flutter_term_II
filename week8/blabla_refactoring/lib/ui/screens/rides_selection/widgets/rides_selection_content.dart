import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:blabla/ui/screens/rides_selection/view_model/rides_selection_view_model.dart';
import 'package:blabla/ui/screens/rides_selection/widgets/ride_preference_modal.dart';
import 'package:blabla/ui/screens/rides_selection/widgets/rides_selection_header.dart';
import 'package:blabla/ui/screens/rides_selection/widgets/rides_selection_tile.dart';
import 'package:flutter/material.dart';

import '../../../../utils/animations_util.dart' show AnimationUtils;
import '../../../theme/theme.dart';

class RidesSelectionContent extends StatelessWidget {
  final RidesSelectionViewModel viewModel;

  const RidesSelectionContent({super.key, required this.viewModel});

  Future<void> onPreferencePressed(BuildContext context, RidePreference currentPreference) async {
    RidePreference? newPreference = await Navigator.of(context).push<RidePreference>(
      AnimationUtils.createRightToLeftRoute(
        RidePreferenceModal(initialPreference: currentPreference),
      ),
    );

    if (!context.mounted) {
      return;
    }

    if (newPreference != null) {
      viewModel.selectPreference(newPreference);
    }
  }

  @override
  Widget build(BuildContext context) {
    final RidePreference? selectedRidePreference = viewModel.selectedPreference;

    if (selectedRidePreference == null) {
      return const Scaffold(
        body: Center(
          child: Text('No ride preference selected yet'),
        ),
      );
    }

    final matchingRides = viewModel.matchingRides;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          children: [
            RideSelectionHeader(
              ridePreference: selectedRidePreference,
              onBackPressed: () => Navigator.pop(context),
              onFilterPressed: viewModel.onFilterPressed,
              onPreferencePressed: () => onPreferencePressed(context, selectedRidePreference),
            ),
            SizedBox(height: 100),
            Expanded(
              child: ListView.builder(
                itemCount: matchingRides.length,
                itemBuilder: (ctx, index) => RideSelectionTile(
                  ride: matchingRides[index],
                  onPressed: () => viewModel.onRideSelected(matchingRides[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
