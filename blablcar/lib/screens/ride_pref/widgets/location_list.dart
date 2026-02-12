import 'package:blablcar/widgets/inputs/location_tile.dart';
import 'package:flutter/material.dart';
import 'package:blablcar/theme/theme.dart';
import '../../../model/ride/locations.dart';
import '../../../widgets/display/bla_divider.dart';

class LocationList extends StatelessWidget {
  final List<Location> locations;
  final ValueChanged<Location> onLocationSelected;

  const LocationList({super.key, required this.locations, required this.onLocationSelected});

  @override
  Widget build(BuildContext context) {
    if (locations.isEmpty) {
      return Center(
        child: Text("No locations found", style: TextStyle(color: BlaColors.greyLight)),
      );
    }
    return ListView.separated(
      itemCount: locations.length,
      separatorBuilder: (context, index) => const BlaDivider(),
      itemBuilder: (context, index) {
        return LocationTile(location: locations[index], onTap: onLocationSelected);
      },
    );
  }
}