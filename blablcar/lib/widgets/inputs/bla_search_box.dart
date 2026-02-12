import 'package:flutter/material.dart';
import 'package:blablcar/theme/theme.dart';

class BlaSearchBox extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const BlaSearchBox({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BlaColors.greyLight,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new, color: BlaColors.iconLight, size: 18),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              autofocus: true,
              onChanged: onChanged,
              style: TextStyle(color: BlaColors.neutral, fontSize: 16),
              decoration: InputDecoration(
                hintText: "Search location...",
                hintStyle: TextStyle(color: BlaColors.greyLight),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: BlaColors.iconLight, size: 20),
            onPressed: onClear,
          ),
        ],
      ),
    );
  }
}