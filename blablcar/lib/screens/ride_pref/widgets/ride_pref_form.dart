import 'package:blablcar/theme/theme.dart';
import 'package:blablcar/utils/animations_util.dart';
import 'package:blablcar/widgets/display/bla_divider.dart';
import 'package:flutter/material.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../utils/date_time_util.dart';
import '../../../screens/ride_pref/location_picker_screen.dart';
import '../../../services/rides_service.dart';
import '../../../widgets/actions/bla_button.dart';
import '../widgets/ride_pref_input.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departureDate = DateTime.now();
      requestedSeats = 1;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void _onLocationPressed(bool isDeparture) async {
    final selectedLocation = await Navigator.push<Location>(
      context,
      AnimationUtils.createBottomToTopRoute(const LocationPickerScreen()),
    );
    
    if (selectedLocation != null) {
      setState(() {
        if (isDeparture) {
          departure = selectedLocation;
        } else {
          arrival = selectedLocation;
        }
      });
    }
  }

  void _onDatePressed() async {

  }

  void _onSeatsPressed() async {

  }

  void _onSearchPressed() async {
    if (departure == null) return;

    final results = RidesService.filterBy(
      departure: departure,
      seatRequested: requestedSeats,
    );
    
    Navigator.pop(context, results);
  }

  void _onSwapLocation() {
    setState(() {
      final preSwapDeparture = departure;
      departure = arrival;
      arrival = preSwapDeparture;
    });
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          // the white form container
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // Departure Field
              RidePrefInput(
                icon: Icons.location_on_outlined,
                label: departure?.name ?? "Leaving from",
                isPlaceholder: departure == null,
                onTap: () => _onLocationPressed(true),

                swapButton: IconButton(
                  icon: const Icon(Icons.swap_vert),
                  onPressed: _onSwapLocation,
                  color: BlaColors.primary,
                ),
              ),
              BlaDivider(),
              // arrival field
              RidePrefInput(
                icon: Icons.location_on_outlined,
                label: arrival?.name ?? "Going to",
                isPlaceholder: arrival == null,
                onTap: () => _onLocationPressed(false),
              ),
              BlaDivider(),
              // Date field
              RidePrefInput(
                icon: Icons.calendar_today_outlined,
                label: DateTimeUtils.formatDateTime(departureDate),
                onTap: _onDatePressed,
              ),
              BlaDivider(),
              // Seats Field
              RidePrefInput(
                icon: Icons.person_outline,
                label: requestedSeats.toString(),
                onTap: _onSeatsPressed,
              )
            ],
          ),
        ),

        const SizedBox(height: 20,),

        // search button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: BlaButton(
              text: "Search",
              onPressed: _onSearchPressed,
            ),
          ),
        )
      ],
    );
  }
}