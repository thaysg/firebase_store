import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'item_size.dart';

class Product extends ChangeNotifier {
  Product({this.id, this.name, this.description, this.images, this.sizes}) {
    images = images ?? [];
    sizes = sizes ?? [];
  }

  Product.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document['name'] as String;
    description = document['description'] as String;
    images = List<String>.from(document.data['images'] as List<dynamic>);

    price = document['price'] as num;

    sizes = (document.data['sizes'] as List<dynamic> ?? [])
        .map((s) => ItemSize.fromMap(s as Map<String, dynamic>))
        .toList();
  }

  final Firestore firestore = Firestore.instance;

  DocumentReference get firestoreRef => firestore.document('products/$id');

  String id;
  String name;
  String description;
  List<String> images;

  num price;

  List<dynamic> newImages;

  List<ItemSize> sizes;

  //Selecionar Produto

  ItemSize _selectedSize;
  ItemSize get selectedSize => _selectedSize;

  set selectedSize(ItemSize value) {
    _selectedSize = value;

    notifyListeners();
  }

//Verificar se tem Stock
  int get totalStock {
    int stock = 0;
    for (final size in sizes) {
      stock += size.stock;
    }
    return stock;
  }

  bool get hasStock {
    return totalStock > 0;
  }

//Receber preço
  num get basePrice {
    num lowest = double.infinity;
    for (final size in sizes) {
      if (size.price < lowest && size.hasStock) {
        lowest = size.price;
      }
    }
    return lowest;
  }

//Carrinho - Recuperar informação do Firebase
  ItemSize findSize(String name) {
    try {
      return sizes.firstWhere((s) => s.name == name);
    } catch (e) {
      return null;
    }
  }

  List<Map<String, dynamic>> exportSizeList() {
    return sizes.map((size) => size.toMap()).toList();
  }

  //Salvar dados no Firebase
  Future<void> save() async {
    final Map<String, dynamic> data = {
      'name': name,
      'description': description,
      'sizes': exportSizeList()
    };
    //Verificar se o produto é novo ou se está editando
    if (id == null) {
      final doc = await firestore.collection('products').add(data);
      id = doc.documentID;
    } else {
      await firestoreRef.updateData(data);
    }
  }

  Product clone() {
    return Product(
      id: id,
      name: name,
      description: description,
      images: List.from(images),
      sizes: sizes.map((size) => size.clone()).toList(),
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, images: $images, sizes: $sizes, newImages: $newImages}';
  }
}
