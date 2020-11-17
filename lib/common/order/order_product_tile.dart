import 'package:firebase_store/models/cart_product.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class OrderProductTile extends StatelessWidget {
  final CartProduct cartProduct;

  // ignore: use_key_in_widget_constructors
  const OrderProductTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed('/detail_product', arguments: cartProduct.product);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: Image.network(cartProduct.product.images.first),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartProduct.product.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Text(
                    'Tamanho: ${cartProduct.size}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 17),
                  ),
                  Text(
                    'R\$ ${(cartProduct.fixedPrice ?? cartProduct.unitPrice).toStringAsFixed(2)}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
            Text(
              '${cartProduct.quantity}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
