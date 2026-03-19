import 'package:blabla/data/repositories/rides/ride_repository.dart';
import 'package:blabla/ui/states/ride_preferences_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_model/rides_selection_view_model.dart';
import 'widgets/rides_selection_content.dart';

///
///  The Ride Selection screen allows user to select a ride, once ride preferences have been defined.
///  The screen also allow user to:
///   -  re-define the ride preferences
///   -  activate some filters.
///
class RidesSelectionScreen extends StatelessWidget {
  const RidesSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RidesSelectionViewModel(
        rideRepository: context.read<RideRepository>(),
        ridePreferencesState: context.read<RidePreferencesState>(),
      ),
      child: Consumer<RidesSelectionViewModel>(
        builder: (context, viewModel, child) => RidesSelectionContent(viewModel: viewModel),
      ),
    );
  }
}
