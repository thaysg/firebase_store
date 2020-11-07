import 'package:firebase_store/common/custom_drawer/custom_drawer.dart';
import 'package:firebase_store/models/page_manager.dart';
import 'package:firebase_store/models/user_manager.dart';
import 'package:firebase_store/screens/admin_users/admin_users_screen.dart';
import 'package:firebase_store/screens/home/home_screen.dart';
import 'package:firebase_store/screens/orders/orders_screen.dart';
import 'package:firebase_store/screens/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(builder: (_, userManager, __) {
        return PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            HomeScreen(),
            ProductsScreen(),
            OrdersScreen(),
            Scaffold(
              drawer: CustomDrawer(),
              appBar: AppBar(
                title: const Text('Home4'),
              ),
            ),
            if (userManager.adminEnabled) ...[
              AdminUsersScreen(),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Pedidos'),
                ),
              ),
            ]
          ],
        );
      }),
    );
  }
}
