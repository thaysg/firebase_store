import 'package:firebase_store/common/custom_drawer/custom_drawer.dart';
import 'package:firebase_store/models/stores_manager.dart';
import 'package:firebase_store/screens/stores/components/store_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class StoresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lojas'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Consumer<StoresManager>(builder: (_, storesManager, __) {
        if (storesManager.stores.isEmpty) {
          return const LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
            backgroundColor: Colors.transparent,
          );
        }

        return ListView.builder(
          itemCount: storesManager.stores.length,
          itemBuilder: (_, index) {
            return StoreCard(storesManager.stores[index]);
          },
        );
      }),
    );
  }
}
