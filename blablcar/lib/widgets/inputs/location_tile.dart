import 'package:flutter/material.dart';
import 'package:blablcar/theme/theme.dart';
import '../../../model/ride/locations.dart';

class LocationTile extends StatelessWidget {
  final Location location;
  final ValueChanged<Location> onTap;

  const LocationTile({super.key, required this.location, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.history, color: BlaColors.iconLight),
      title: Text(
        location.name,
        style: TextStyle(color: BlaColors.neutral, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(location.country.name, style: TextStyle(color: BlaColors.greyLight)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: BlaColors.iconLight),
      onTap: () => onTap(location),
    );
  }
}