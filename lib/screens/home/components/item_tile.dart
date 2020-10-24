import 'package:firebase_store/models/product_manager.dart';
import 'package:firebase_store/models/section_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemTile extends StatelessWidget {
  final SectionItem item;

  // ignore: use_key_in_widget_constructors
  const ItemTile(this.item);

  @override
  Widget build(BuildContext context) {
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
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image.network(
                item.image,
                height: 100,
                //fit: BoxFit.fitHeight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}
