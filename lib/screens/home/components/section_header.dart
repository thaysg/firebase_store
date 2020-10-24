import 'package:firebase_store/models/section.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final Section section;
  // ignore: use_key_in_widget_constructors
  const SectionHeader(this.section);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        section.name,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
    );
  }
}
