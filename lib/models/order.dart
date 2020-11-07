import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_store/models/address.dart';
import 'package:firebase_store/models/cart_manager.dart';
import 'package:firebase_store/models/cart_product.dart';

class Order {
  Order.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userID = cartManager.user.id;
    address = cartManager.address;
  }

  Order.fromDocument(DocumentSnapshot doc) {
    orderId = doc.documentID;

    items = (doc.data['items'] as List<dynamic>).map((e) {
      return CartProduct.fromMap(e as Map<String, dynamic>);
    }).toList();

    price = doc.data['price'] as num;
    userID = doc.data['user'] as String;
    address = Address.fromMap(doc.data['address'] as Map<String, dynamic>);
    date = doc.data['data'] as Timestamp;
  }

  final Firestore firestore = Firestore.instance;

  Future<void> save() async {
    firestore.collection('orders').document(orderId).setData({
      'items': items.map((e) => e.toOrderItemMap()).toList(),
      'price': price,
      'user': userID,
      'address': address.toMap(),
    });
  }

  String orderId;

  List<CartProduct> items;
  num price;

  String userID;

  Address address;

  Timestamp date;

  String get formattedId => '#${orderId.padLeft(6, '0')}';

  @override
  String toString() {
    // TODO: implement toString
    return 'Order{firestore: $firestore, orderId: $orderId, items: $items, price: $price, userId: $userID, address: $address, date: $date}';
  }
}
