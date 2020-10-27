import 'package:firebase_store/models/home_manager.dart';
import 'package:firebase_store/models/section.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class AddSectionWidget extends StatelessWidget {
  final HomeManager homeManager;

  // ignore: use_key_in_widget_constructors
  const AddSectionWidget(this.homeManager);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: FlatButton(
                onPressed: () {
                  homeManager.addSection(Section(type: 'List'));
                },
                textColor: Colors.white,
                child: const Text('Adicionar Lista'))),
        Expanded(
            child: FlatButton(
                onPressed: () {
                  homeManager.addSection(Section(type: 'Staggered'));
                },
                textColor: Colors.white,
                child: const Text('Adicionar Grade')))
      ],
    );
  }
}
