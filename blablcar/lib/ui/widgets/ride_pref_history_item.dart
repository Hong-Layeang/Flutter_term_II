import 'package:flutter/material.dart';

import '../../models/ride_pref/ride_pref.dart';
import '../../utils/date_time_utils.dart';

class RidePrefHistoryItem extends StatelessWidget {
  final RidePref ridePref;
  final VoidCallback onTap;

const RidePrefHistoryItem({ 
  super.key,
  required this.ridePref,
  required this.onTap,
});

  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: onTap, 
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFECEFF1), width: 1),
          )
        ),
        child: Row(
          children: [
            Icon(
              Icons.access_time,
              color: Color(0xFF78909C),
              size: 20,
            ),
            SizedBox(width: 16,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${ridePref.departure.name} → ${ridePref.arrival.name}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF37474F),
                    ),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    '${DateTimeUtils.formatDateTime(ridePref.departureDate)}, ${ridePref.requestedSeats} passengers${ridePref.requestedSeats > 1 ? 's' : ''}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF78909C),
                    )
                  )
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Color(0xFFB0BEC5),
            )
          ],
        ),
      ),
    );
  }
}