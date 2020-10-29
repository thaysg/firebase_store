import 'dart:io';

import 'package:firebase_store/models/home_manager.dart';
import 'package:firebase_store/models/product_manager.dart';
import 'package:firebase_store/models/section.dart';
import 'package:firebase_store/models/section_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget {
  final SectionItem item;

  // ignore: use_key_in_widget_constructors
  const ItemTile(this.item);

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();

    return GestureDetector(
      onTap: () {
        if (item.product != null) {
          final product =
              context.read<ProductManager>().findProductByID(item.product);
          if (product != null) {
            Navigator.of(context)
                .pushNamed('/detail_product', arguments: product);
          }
        }
      },
      onLongPress: homeManager.editing
          ? () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: const Text('Editar Item'),
                      actions: [
                        FlatButton(
                            onPressed: () {
                              context.read<Section>().removeItem(item);
                              Navigator.of(context).pop();
                            },
                            textColor: Colors.red,
                            child: const Text('Excluir'))
                      ],
                    );
                  });
            }
          : null,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AspectRatio(
            aspectRatio: 1,
            child: item.image is String
                ? FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: item.image as String,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    item.image as File,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }
}
