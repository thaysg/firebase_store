import 'package:firebase_store/screens/cart/cart_screen.dart';
import 'package:firebase_store/screens/home/home_screen.dart';
import 'package:firebase_store/screens/products/products_screen.dart';
import 'package:flutter/material.dart';

class NavigationBarCustom extends StatefulWidget {
  @override
  _NavigationBarCustomState createState() => _NavigationBarCustomState();
}

class _NavigationBarCustomState extends State<NavigationBarCustom> {
  int _currentIndex = 0;
  final List<Widget> _pages = [HomeScreen(), ProductsScreen(), CartScreen()];

  void selectedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          //fixedColor: Colors.white,
          /* onTap: selectedBar,
          currentIndex: _currentIndex, */
          items: [
            BottomNavigationBarItem(
                icon: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/home');
                    },
                    child: const Icon(Icons.home)),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/products');
                    },
                    child: const Icon(Icons.list)),
                label: 'Produtos'),
            BottomNavigationBarItem(
                icon: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/cart');
                    },
                    child: const Icon(Icons.shopping_cart)),
                label: 'Carrinho')
          ]),
    );
  }
}
