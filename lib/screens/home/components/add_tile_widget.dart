import 'dart:io';

import 'package:firebase_store/models/section.dart';
import 'package:firebase_store/models/section_item.dart';
import 'package:firebase_store/screens/edit_product/components/image_source_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class ItemTileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final section = context.watch<Section>();

    void onImageSelected(File file) {
      section.addItem(SectionItem(image: file));
      Navigator.of(context).pop();
    }

    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () {
          if (Platform.isAndroid) {
            showModalBottomSheet(
              context: context,
              builder: (context) => ImageSourceSheet(
                onImageSelected: onImageSelected,
              ),
            );
          } else {
            showCupertinoModalPopup(
                context: context,
                builder: (context) => ImageSourceSheet(
                      onImageSelected: onImageSelected,
                    ));
          }
        },
        child: Container(
          color: Colors.white.withAlpha(30),
          child: const Icon(
            FontAwesomeIcons.plus,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
