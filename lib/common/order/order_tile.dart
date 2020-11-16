import 'package:firebase_store/common/order/cancel_order_dialog.dart';
import 'package:firebase_store/common/order/export_address_dialog.dart';
import 'package:firebase_store/models/order.dart';
import 'package:firebase_store/common/order/order_product_tile.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  final bool showControls;

  // ignore: use_key_in_widget_constructors
  const OrderTile(this.order, {this.showControls = false});

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
              order.statusText,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: order.status == Status.canceled
                      ? Colors.red
                      : Colors.green,
                  fontSize: 14),
            )
          ],
        ),
        children: [
          Column(
              children: order.items.map((e) {
            return OrderProductTile(e);
          }).toList()),
          if (showControls && order.status != Status.canceled)
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  FlatButton.icon(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => CancelOrderDialog(order));
                    },
                    icon: const Icon(Icons.cancel),
                    label: const Text('Cancelar'),
                    textColor: Colors.red,
                  ),
                  FlatButton.icon(
                    onPressed: order.back,
                    icon: const Icon(Icons.replay_circle_filled),
                    label: const Text('Recuar'),
                    textColor: Colors.amber,
                  ),
                  FlatButton.icon(
                    onPressed: order.advance,
                    icon: const Icon(Icons.play_circle_fill),
                    label: const Text('Avançar'),
                    textColor: Colors.blue,
                  ),
                  FlatButton.icon(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => ExportAddressDialog(order.address));
                    },
                    icon: const Icon(Icons.location_city_rounded),
                    label: const Text('Endereço'),
                    textColor: Colors.green,
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
