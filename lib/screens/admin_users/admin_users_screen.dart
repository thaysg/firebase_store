import 'package:firebase_store/common/custom_drawer/custom_drawer.dart';
import 'package:firebase_store/models/admin_orders_manager.dart';
import 'package:firebase_store/models/admin_users_manage.dart';
import 'package:firebase_store/models/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class AdminUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: const Text('Usuários'),
          centerTitle: true,
        ),
        body: Consumer<AdminUsersManager>(builder: (_, adminUsersManager, __) {
          return AlphabetListScrollView(
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(
                  adminUsersManager.users[index].name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                subtitle: Text(
                  adminUsersManager.users[index].email,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  context
                      .read<AdminOrdersManager>()
                      .setUserFilter(adminUsersManager.users[index]);
                  context.read<PageManager>().setPage(5);
                },
              );
            },
            highlightTextStyle:
                const TextStyle(color: Colors.white, fontSize: 20),
            strList: adminUsersManager.names,
            indexedHeight: (index) => 80,
            showPreview: true,
          );
        }));
  }
}
