import 'package:firebase_store/models/order.dart';
import 'package:firebase_store/screens/orders/components/order_product_tile.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final Order order;

  // ignore: use_key_in_widget_constructors
  const OrderTile(this.order);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.formattedId,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: primaryColor),
                ),
                Text(
                  'R\$ ${order.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14),
                )
              ],
            ),
            Text(
              'Em Transporte',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: primaryColor,
                  fontSize: 14),
            )
          ],
        ),
        children: [
          Column(
              children: order.items.map((e) {
            return OrderProductTile(e);
          }).toList())
        ],
      ),
    );
  }
}
