import 'package:firebase_store/common/price_card/price_card.dart';
import 'package:firebase_store/models/cart_manager.dart';
import 'package:firebase_store/models/checkout_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class CheckoutScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) =>
          checkoutManager..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: const Text('Pagamento'),
            centerTitle: true,
          ),
          body: Consumer<CheckoutManager>(builder: (_, checkoutManager, __) {
            if (checkoutManager.loading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Processando Pagamento',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              );
            }
            return ListView(
              children: [
                PriceCard(
                  buttonText: 'Finalizar Pagamento',
                  onPressed: () {
                    checkoutManager.checkout(onStockFail: (e) {
                      Navigator.of(context)
                          .popUntil((route) => route.settings.name == '/cart');
                    }, onSuccess: (order) {
                      Navigator.of(context)
                          .popUntil((route) => route.settings.name == '/base');
                      Navigator.of(context)
                          .pushNamed('/confirmation', arguments: order);
                    });
                  },
                )
              ],
            );
          })),
    );
  }
}
