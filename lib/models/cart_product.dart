import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_store/models/item_size.dart';
import 'package:firebase_store/models/product.dart';
import 'package:flutter/cupertino.dart';

class CartProduct extends ChangeNotifier {
  CartProduct.fromProduct(this._product) {
    productId = product.id;
    quantity = 1;
    size = product.selectedSize.name;
  }

  //Construtor do CartManager{
  CartProduct.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    productId = document.data['pid'] as String;
    quantity = document.data['quantity'] as int;
    size = document.data['size'] as String;

    firestore.document('products/$productId').get().then((doc) {
      product = Product.fromDocument(doc);
    });
  }

  CartProduct.fromMap(Map<String, dynamic> map) {
    productId = map['pid'] as String;
    quantity = map['quantity'] as int;
    size = map['size'] as String;
    fixedPrice = map['fixedPrice'] as num;

    firestore.document('products/$productId').get().then((doc) {
      product = Product.fromDocument(doc);
    });
  }

  final Firestore firestore = Firestore.instance;
  // Constrtutor do CartManager}

  //Campos salvos do firebase
  String id;

  String productId;
  int quantity;
  String size;

  num fixedPrice;

  Product _product;
  Product get product => _product;
  set product(Product value) {
    _product = value;
    notifyListeners();
  }

  //Getter pegar tamanho do produto e preço
  ItemSize get itemSize {
    if (product == null) {
      return null;
    }
    return product.findSize(size);
  }

  num get unitPrice {
    if (product == null) return 0;
    return itemSize?.price ?? 0;
  }

  num get totalPrice => unitPrice * quantity;

  //Salvar Carrinho no Firebase{
  Map<String, dynamic> toCartItemMap() {
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
    };
  }
// }

  Map<String, dynamic> toOrderItemMap() {
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
      'fixedPrice': fixedPrice ?? unitPrice,
    };
  }

//Incrementar produtos no carrinho{
  bool stackable(Product product) {
    return product.id == productId && product.selectedSize.name == size;
  }

  void increment() {
    quantity++;
    notifyListeners();
  }

  void decrement() {
    quantity--;
    notifyListeners();
  }
// }

  //Verificar quantidade disponivel no estoque para venda{
  bool get hasStock {
    if (product != null && product.deleted) return false;

    final size = itemSize;
    if (size == null) return false;
    return size.stock >= quantity;
  }
// }
}
