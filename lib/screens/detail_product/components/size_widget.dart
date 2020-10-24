import 'package:firebase_store/models/item_size.dart';
import 'package:firebase_store/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SizeWidget extends StatelessWidget {

  final ItemSize size;

  // ignore: use_key_in_widget_constructors
  const SizeWidget({this.size});

  @override
  Widget build(BuildContext context) {

    final product = context.watch<Product>();
    final selected = size == product.selectedSize;

    Color color;
    if(!size.hasStock){
      color = Colors.red.withAlpha(80);
    }else if(selected){
      color = Colors.green;
    }else{
      color = Colors.grey;
    }


    return GestureDetector(
      onTap: (){
        if(size.hasStock){
          product.selectedSize=size;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: color
          )
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                color: color,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                size.name,
                style: const TextStyle(
                  color: Colors.white
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
