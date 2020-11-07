import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_store/models/cart_manager.dart';
import 'package:firebase_store/models/order.dart';
import 'package:firebase_store/models/product.dart';
import 'package:flutter/cupertino.dart';

class CheckoutManager extends ChangeNotifier {
  CartManager cartManager;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final Firestore firestore = Firestore.instance;

  // ignore: use_setters_to_change_properties
  void updateCart(CartManager cartManager) {
    this.cartManager = cartManager;
  }

  Future<void> checkout({Function onStockFail, Function onSuccess}) async {
    loading = true;

    try {
      await _decrementStock();
    } catch (e) {
      onStockFail(e);
      loading = false;
      return;
    }

    final orderId = await _getOrderId();

    final order = Order.fromCartManager(cartManager);
    order.orderId = orderId.toString();

    await order.save();

    cartManager.clear();

    onSuccess(order);

    loading = false;
  }

  Future<int> _getOrderId() async {
    try {
      final ref = firestore.document('aux/orderCounter');
      final result = await firestore.runTransaction((transaction) async {
        final doc = await transaction.get(ref);
        final orderId = doc.data['current'] as int;
        await transaction.update(ref, {'current': orderId + 1});
        return {'orderId': orderId};
      }, timeout: const Duration(seconds: 10));
      return result['orderId'] as int;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error('Falaha ao Gerar Número do Pedido');
    }
  }

  Future<void> _decrementStock() {
    return firestore.runTransaction((transaction) async {
      final List<Product> productsToUpdate = [];
      final List<Product> productWithoutStock = [];

      for (final cartProduct in cartManager.items) {
        Product product;

        if (productsToUpdate.any((p) => p.id == cartProduct.productId)) {
          product =
              productsToUpdate.firstWhere((p) => p.id == cartProduct.productId);
        } else {
          final doc = await transaction
              .get(firestore.document('products/${cartProduct.productId}'));
          product = Product.fromDocument(doc);
        }

        cartProduct.product = product;

        final size = product.findSize(cartProduct.size);
        if (size.stock - cartProduct.quantity < 0) {
          productWithoutStock.add(product);
        } else {
          size.stock -= cartProduct.quantity;
          productsToUpdate.add(product);
        }
      }

      if (productWithoutStock.isNotEmpty) {
        return Future.error(
            '${productWithoutStock.length} Produto sem Estoque');
      }
      for (final product in productsToUpdate) {
        transaction.update(firestore.document('products/${product.id}'),
            {'sizes': product.exportSizeList()});
      }
    });
  }
}
