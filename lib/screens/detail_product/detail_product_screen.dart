import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_store/models/cart_manager.dart';
import 'package:firebase_store/models/product.dart';
import 'package:firebase_store/models/user_manager.dart';
import 'package:firebase_store/screens/detail_product/components/size_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DetailProductScreen extends StatelessWidget {

  final Product product;

  // ignore: use_key_in_widget_constructors
  const DetailProductScreen(this.product);


  @override
  Widget build(BuildContext context) {

    final secondaryColor = Theme.of(context).secondaryHeaderColor;
    final primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.name),
          centerTitle: true,
          actions: [
            Consumer<UserManager>(
                builder: (_, userManager, __){
                  if(userManager.adminEnabled){
                    return IconButton(
                        icon: const Icon(FontAwesomeIcons.edit,),
                        onPressed: (){
                          Navigator.of(context).pushReplacementNamed(
                              '/edit_product',
                            arguments: product
                          );
                        }
                    );
                  }else{
                    return Container();
                  }
                }
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                images:
                  product.images.map((url){
                    return NetworkImage(url);
                  }).toList(),
                dotSpacing: 14,
                dotSize: 4,
                dotBgColor: Colors.transparent,
                dotColor: Theme.of(context).primaryColor,
                autoplay: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    //TODO: trocar para valor real
                    child: Text(
                      'R\$ ${product.basePrice.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Descrição',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16
                      ),
                    ),
                  ),
                  Text(
                    product.description,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Tamanhos',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                      ),
                    ),
                  ),
                  Center(
                    child: Wrap(
                      spacing: 8,
                      children:
                        product.sizes.map((s){
                          return SizeWidget(size: s);
                        }).toList(),
                    )
                  ),
                  const SizedBox(height: 20,),
                  if(product.hasStock)
                  Consumer2<UserManager, Product>(
                      builder: (_, userManager, product, __){
                        return SizedBox(
                          height: 44,
                          child: RaisedButton(
                              onPressed: product.selectedSize != null ?(){
                                if(userManager.isLoggedIn){
                                  context.read<CartManager>().addToCart(product);
                                  Navigator.of(context).pushNamed('/cart');
                                }else{
                                  Navigator.of(context).pushNamed('/login');
                                }
                              } : null,
                            color: primaryColor,
                            disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                            textColor: Colors.white,
                            child: Text(
                              userManager.isLoggedIn
                                  ? 'Adicionar ao Carrinho'
                                  : 'Entre para Comprar',
                              style: const TextStyle(
                                fontSize: 18
                              ),
                            ),
                          ),
                        );
                      }
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
