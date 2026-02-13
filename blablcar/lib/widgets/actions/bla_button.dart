import 'package:blablcar/theme/theme.dart';
import 'package:flutter/material.dart';

class BlaButton extends StatelessWidget {
  final IconData? icon;
  final String text;
  final VoidCallback onPressed;
  final Color? textColor;
  final Color? backgroundColor;

  const BlaButton({
    super.key,
    this.icon,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? BlaColors.primary;
    final Color fgColor = textColor ?? Colors.white;

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(15),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          )
        ),
        child: _buildContent(fgColor),
      ),
    );
  }

  Widget _buildContent(Color fgColor) {
    if (icon == null) {
      return Text(text);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 20, color: fgColor,),
        const SizedBox(width: 8,),
        Text(text),
      ],
    );
  }
}