import 'package:firebase_store/common/custom_drawer/custom_drawer.dart';
import 'package:firebase_store/models/product_manager.dart';
import 'package:firebase_store/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'components/product_list_tile.dart';
import 'components/search_dialog.dart';

// ignore: use_key_in_widget_constructors
class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Consumer<ProductManager>(builder: (_, productManager, __) {
          if (productManager.search.isEmpty) {
            return const Text('Produtos');
          } else {
            return LayoutBuilder(builder: (_, constraints) {
              return GestureDetector(
                onTap: () async {
                  final search = await showDialog<String>(
                      context: context,
                      builder: (_) => SearchDialog(productManager.search));
                  if (search != null) {
                    productManager.search = search;
                  }
                },
                // ignore: sized_box_for_whitespace
                child: Container(
                    width: constraints.biggest.width,
                    child: Text(
                      productManager.search,
                      textAlign: TextAlign.center,
                    )),
              );
            });
          }
        }),
        centerTitle: true,
        actions: [
          Consumer<ProductManager>(builder: (_, productManager, __) {
            if (productManager.search.isEmpty) {
              return IconButton(
                  icon: const Icon(
                    Icons.search,
                    size: 22,
                  ),
                  onPressed: () async {
                    final search = await showDialog<String>(
                        context: context,
                        builder: (_) => SearchDialog(productManager.search));
                    if (search != null) {
                      productManager.search = search;
                    }
                  });
            } else {
              return IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () async {
                    productManager.search = '';
                  });
            }
          }),
          Consumer<UserManager>(builder: (_, userManager, __) {
            if (userManager.adminEnabled) {
              return IconButton(
                  icon: const Icon(
                    Icons.add,
                    size: 22,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      '/edit_product',
                    );
                  });
            } else {
              return Container();
            }
          })
        ],
      ),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __) {
          final filteredProducts = productManager.filteredProducts;
          return ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (_, index) {
                return ProductListTile(filteredProducts[index]);
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/cart');
        },
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        child: const Icon(FontAwesomeIcons.shoppingCart),
      ),
    );
  }
}
