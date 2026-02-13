import 'package:flutter/material.dart';
import '../../dummy_data/dummy_data.dart';
import '../../model/ride/locations.dart';
import '../../widgets/inputs/bla_search_box.dart';
import '../../screens/ride_pref/widgets/location_list.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  List<Location> filteredLocations = [];
  final TextEditingController _searchController = TextEditingController();

  void _onSearchChanged(String input) {
    setState(() {
      if (input.isEmpty) {
        filteredLocations = [];
      } else {
        filteredLocations = fakeLocations
            .where((loc) =>
                  loc.name.toLowerCase().contains(input.toLowerCase()) ||
                  loc.country.name.toLowerCase().contains(input.toLowerCase()),
            ).toList();
      }
    });
  }

  void _onLocationSelected(Location location) {
    Navigator.pop(context, location);
  }

  void _onClearSearch() {
    _searchController.clear();
    _onSearchChanged("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlaSearchBox(
                controller: _searchController,
                onChanged: _onSearchChanged,
                onClear: _onClearSearch,
              ),
            ),
            Expanded(
              child: LocationList(
                locations: filteredLocations,
                onLocationSelected: _onLocationSelected,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
