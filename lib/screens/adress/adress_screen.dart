import 'package:firebase_store/common/price_card/price_card.dart';
import 'package:firebase_store/models/cart_manager.dart';
import 'package:firebase_store/screens/adress/components/adress_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          Consumer<CartManager>(
            builder: (_, cartManager, __) {
              return PriceCard(
                buttonText: 'Continuar para o Pagamento',
                onPressed: cartManager.isAddressValid ? () {} : null,
              );
            },
          ),
        ],
      ),
    );
  }
}
