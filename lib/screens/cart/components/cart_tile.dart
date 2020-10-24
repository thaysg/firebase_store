import 'package:firebase_store/common/custom_icon_button/custom_icon_button.dart';
import 'package:firebase_store/models/cart_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;

  // ignore: use_key_in_widget_constructors
  const CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    final secondaryColor = Theme.of(context).secondaryHeaderColor;

    return ChangeNotifierProvider.value(
      value: cartProduct,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(cartProduct.product.images.first),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartProduct.product.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Tamanho ${cartProduct.size}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                    ),
                    Consumer<CartProduct>(
                      builder: (_, cartProduct, __) {
                        if (cartProduct.hasStock) {
                          return Text(
                            'R\$ ${cartProduct.unitPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          );
                        } else {
                          return const Text(
                            'Produto sem Estoque',
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          );
                        }
                      },
                    )
                  ],
                ),
              )),
              Consumer<CartProduct>(builder: (_, cartProduct, __) {
                return Column(
                  children: [
                    CustomIConButtton(
                      iconData: Icons.add,
                      color: secondaryColor,
                      onTap: cartProduct.increment,
                    ),
                    Text(
                      '${cartProduct.quantity}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    CustomIConButtton(
                      iconData: Icons.remove,
                      color: cartProduct.quantity > 1
                          ? secondaryColor
                          : Colors.redAccent,
                      onTap: cartProduct.decrement,
                    ),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
