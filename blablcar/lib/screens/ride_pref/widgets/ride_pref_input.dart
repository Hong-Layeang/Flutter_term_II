import 'package:blablcar/theme/theme.dart';
import 'package:flutter/material.dart';

class RidePrefInput extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isPlaceholder;
  final Widget? swapButton;

  const RidePrefInput({ 
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isPlaceholder = false,
    this.swapButton,
  });

  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: BlaColors.iconLight, size: 24,),
            const SizedBox(width: 16,),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  color: isPlaceholder ? BlaColors.greyLight : BlaColors.neutral,
                  fontWeight: isPlaceholder ? FontWeight.normal : FontWeight.w500
                ),
              ),
            ),
            ?swapButton, //display its widget if provided
          ],
        ),
      )
    );
  }
}