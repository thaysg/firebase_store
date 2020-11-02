import 'package:firebase_store/screens/adress/components/adress_cart.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class AdressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrega'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AdressCart(),
        ],
      ),
    );
  }
}
