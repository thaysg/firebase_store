import 'package:flutter/material.dart';

class CustomIConButtton extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final VoidCallback onTap;
  final double size;

  // ignore: use_key_in_widget_constructors
  const CustomIConButtton({this.iconData, this.color, this.onTap, this.size});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              iconData,
              color: onTap != null ? color : Colors.grey[500],
              size: size ?? 24,
            ),
          ),
        ),
      ),
    );
  }
}
