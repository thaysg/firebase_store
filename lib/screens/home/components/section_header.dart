import 'package:firebase_store/common/custom_icon_button/custom_icon_button.dart';
import 'package:firebase_store/models/home_manager.dart';
import 'package:firebase_store/models/section.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class SectionHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    final section = context.watch<Section>();

    if (homeManager.editing) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: section.name,
                  decoration: const InputDecoration(
                      hintText: 'Título',
                      isDense: true,
                      border: InputBorder.none),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 18),
                  onChanged: (text) => section.name = text,
                ),
              ),
              CustomIConButtton(
                iconData: FontAwesomeIcons.minusCircle,
                color: Colors.white,
                onTap: () {
                  homeManager.removeSection(section);
                },
              )
            ],
          ),
          if (section.error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                section.error,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          section.name ?? '',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      );
    }
  }
}
