import 'package:firebase_store/models/address.dart';
import 'package:firebase_store/models/cart_manager.dart';
import 'package:firebase_store/screens/adress/components/address_input_field.dart';
import 'package:firebase_store/screens/adress/components/cep_inpu_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class AdressCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Consumer<CartManager>(builder: (_, cartManager, __) {
              final address = cartManager.address ?? Address();
              return Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Endereço de Entrega',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    CepInputField(address),
                    AddressInputField(address),
                  ],
                ),
              );
            })));
  }
}
