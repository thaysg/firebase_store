import 'package:firebase_store/models/product.dart';
import 'package:firebase_store/screens/edit_product/components/images_form.dart';
import 'package:firebase_store/screens/edit_product/components/sizes_form.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;

  // ignore: use_key_in_widget_constructors
  EditProductScreen(Product p) : product = p != null ? p : Product();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Produto'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            ImagesForm(product),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    initialValue: product.name,
                    decoration: const InputDecoration(
                        hintText: 'Título', border: InputBorder.none),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    validator: (name) {
                      if (name.length < 6) {
                        return 'Título muito curto';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    initialValue: product.basePrice.toStringAsFixed(2),
                    decoration: const InputDecoration(
                        hintText: 'Preço',
                        prefixText: 'R\$ ',
                        border: InputBorder.none),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900]),
                    validator: (price) {
                      if (price == 0) {
                        return 'Digite o valor do Produto';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Descrição',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                  ),
                  TextFormField(
                    initialValue: product.description,
                    decoration: const InputDecoration(
                        hintText: 'Descrição do Produto',
                        border: InputBorder.none),
                    maxLines: null,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    validator: (desc) {
                      if (desc.length < 10) {
                        return 'Descrição muito curta';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizesForm(product),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      color: primaryColor,
                      disabledColor: primaryColor.withAlpha(100),
                      textColor: Colors.white,
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          print('válido');
                        } else {
                          print('inválido');
                        }
                      },
                      child: const Text(
                        'Salvar',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
