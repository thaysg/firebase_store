import 'package:firebase_store/common/custom_drawer/custom_drawer_header.dart';
import 'package:firebase_store/common/custom_drawer/custom_tile.dart';
import 'package:firebase_store/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xffc22e22),
              Color(0xffe52d3c),
              Color(0xffc7554a),
              Color(0xffcf6060),
              Color(0xffe47267),
              /*Colors.red.shade900,
                  Colors.red.shade700,
                  Colors.red.shade600,
                  Colors.red.shade500,*/
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          ListView(
            children: [
              CustomDrawerHeader(),
              const DrawerTile(
                iconData: FontAwesomeIcons.home,
                title: 'Home',
                page: 0,
              ),
              const DrawerTile(
                iconData: FontAwesomeIcons.list,
                title: 'Produtos',
                page: 1,
              ),
              const DrawerTile(
                iconData: FontAwesomeIcons.cartPlus,
                title: 'Meus Pedidos',
                page: 2,
              ),
              const DrawerTile(
                iconData: FontAwesomeIcons.locationArrow,
                title: 'Lojas',
                page: 3,
              ),
              Consumer<UserManager>(builder: (_, userManager, __) {
                if (userManager.adminEnabled) {
                  return Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Divider(),
                      const DrawerTile(
                        iconData: FontAwesomeIcons.users,
                        title: 'Usuários',
                        page: 4,
                      ),
                      const DrawerTile(
                        // ignore: prefer_const_literals_to_create_immutables, prefer_const_literals_to_create_immutables, prefer_const_literals_to_create_immutables, prefer_const_literals_to_create_immutables, prefer_const_literals_to_create_immutables
                        iconData: Icons.shopping_basket,
                        title: 'Pedidos',
                        page: 5,
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              })
            ],
          ),
        ],
      ),
    );
  }
}
