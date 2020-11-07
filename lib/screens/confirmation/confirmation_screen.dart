import 'package:firebase_store/models/order.dart';
import 'package:firebase_store/screens/orders/components/order_product_tile.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ConfirmationScreen extends StatelessWidget {
  final Order order;

  // ignore: use_key_in_widget_constructors
  const ConfirmationScreen(this.order);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido ${order.formattedId} Confirmado'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.formattedId,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Text(
                      'R\$ ${order.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Column(
                  children: order.items.map((e) {
                return OrderProductTile(e);
              }).toList())
            ],
          ),
        ),
      ),
    );
  }
}
