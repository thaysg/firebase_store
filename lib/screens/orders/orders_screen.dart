import 'package:firebase_store/common/custom_drawer/custom_drawer.dart';
import 'package:firebase_store/common/empty_card/empty_card.dart';
import 'package:firebase_store/common/login_card/login_card.dart';
import 'package:firebase_store/models/orders_manager.dart';
import 'package:firebase_store/common/order/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        centerTitle: true,
      ),
      body: Consumer<OrdersManager>(builder: (_, ordersManager, __) {
        if (ordersManager.user == null) {
          return LoginCard();
        }
        if (ordersManager.orders.isEmpty) {
          return const EmptyCard(
            title: 'Nenhum Produto Encontrado',
            iconData: Icons.border_clear,
          );
        }
        return ListView.builder(
            itemCount: ordersManager.orders.length,
            itemBuilder: (_, index) {
              return OrderTile(ordersManager.orders.reversed.toList()[index]);
            });
      }),
    );
  }
}
