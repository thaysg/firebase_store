import 'package:firebase_store/models/order.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class CancelOrderDialog extends StatelessWidget {
  final Order order;

  // ignore: use_key_in_widget_constructors
  const CancelOrderDialog(this.order);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Cancelar ${order.formattedId}?'),
      content: const Text('Está Ação não Poderá ser Desfeita'),
      actions: [
        FlatButton(
          onPressed: () {
            order.cancel();
            Navigator.of(context).pop();
          },
          textColor: Colors.red,
          child: const Text('Cancelar Pedido'),
        )
      ],
    );
  }
}
