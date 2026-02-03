import 'package:flutter/material.dart';

import '../../ui/widgets/hero_banner.dart';
import '../../data/dummy_data.dart';
import '../widgets/ride_pref_history_item.dart';

class RidePrefsScreen extends StatefulWidget {
  const RidePrefsScreen({ super.key });

  @override
  State<RidePrefsScreen> createState() => _RidePrefsScreenState();
}

class _RidePrefsScreenState extends State<RidePrefsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeroBanner(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // ride pref form

                    _buildHistorySection(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildHistorySection() {
  return Container(
    margin: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          offset: Offset(0, 4),
        )
      ]
    ),
    child: Column(
      children: fakeRidePrefs.take(4).map((ridePref) {
        return RidePrefHistoryItem(
          ridePref: ridePref,
          onTap: () {
            // Handle history item map later
          }
        );
      }).toList(),
    ),
  );
}