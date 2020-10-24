import 'package:firebase_store/models/admin_users_manage.dart';
import 'package:firebase_store/models/home_manager.dart';
import 'package:firebase_store/models/product.dart';
import 'package:firebase_store/models/product_manager.dart';
import 'package:firebase_store/models/user_manager.dart';
import 'package:firebase_store/screens/base/base_screen.dart';
import 'package:firebase_store/screens/cart/cart_screen.dart';
import 'package:firebase_store/screens/detail_product/detail_product_screen.dart';
import 'package:firebase_store/screens/edit_product/edit_product_screen.dart';
import 'package:firebase_store/screens/login/login_screen.dart';
import 'package:firebase_store/screens/sign_up/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/cart_manager.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
              cartManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
            create: (_) => AdminUsersManager(),
            lazy: false,
            update: (_, userManager, adminUsersManager) =>
                adminUsersManager..updateUser(userManager))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TG Store',
        theme: ThemeData(
          primaryColor: const Color(
              0xffe52d3c), //Colors.red.shade900,//const Color.fromARGB(255, 135, 206, 235),
          secondaryHeaderColor: Colors.blue[900],
          scaffoldBackgroundColor: const Color(0xffe52d3c), //.withAlpha(50),
          //Colors.white70.withAlpha(200),
          //scaffoldBackgroundColor: const Color.fromARGB(255, 135, 206, 235),
          appBarTheme: const AppBarTheme(elevation: 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case '/sign_up':
              return MaterialPageRoute(builder: (_) => SignUpScreen());
            case '/detail_product':
              return MaterialPageRoute(
                  builder: (_) =>
                      DetailProductScreen(settings.arguments as Product));
            case '/cart':
              return MaterialPageRoute(builder: (_) => CartScreen());
            case '/edit_product':
              return MaterialPageRoute(
                  builder: (_) =>
                      EditProductScreen(settings.arguments as Product));
            case '/base':
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
