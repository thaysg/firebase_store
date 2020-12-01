import 'package:firebase_store/common/empty_card/empty_card.dart';
import 'package:firebase_store/common/login_card/login_card.dart';
import 'package:firebase_store/common/price_card/price_card.dart';
import 'package:firebase_store/models/cart_manager.dart';
import 'package:firebase_store/screens/cart/components/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(builder: (_, cartManager, __) {
        if (cartManager.user == null) {
          return LoginCard();
        }

        if (cartManager.items.isEmpty) {
          return const EmptyCard(
            iconData: Icons.remove_shopping_cart,
            title: 'Nenhum Produto no Carrinho',
          );
        }

        return ListView(
          children: [
            Column(
              children: cartManager.items
                  .map((cartProduct) => CartTile(cartProduct))
                  .toList(),
            ),
            PriceCard(
              buttonText: 'Continuar para Entrega',
              onPressed: cartManager.isCartValid
                  ? () {
                      Navigator.of(context).pushNamed('/adress');
                    }
                  : null,
            ),
          ],
        );
      }),

      //bottomNavigationBar: NavigationBarCustom(),
      /* bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/cart');
                },
                child: const Icon(Icons.shopping_cart)),
            label: 'Carrinho',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/home');
                },
                child: const Icon(Icons.home)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/products');
                  },
                  child: const Icon(Icons.list_alt)),
              label: 'Produtos'),
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        ],
      ), */
    );
  }
}
