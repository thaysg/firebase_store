import 'package:firebase_store/models/product.dart';
import 'package:firebase_store/models/product_manager.dart';
import 'package:firebase_store/screens/edit_product/components/images_form.dart';
import 'package:firebase_store/screens/edit_product/components/sizes_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;
  final bool editing;

  // ignore: use_key_in_widget_constructors
  EditProductScreen(Product p)
      : editing = p != null,
        product = p != null ? p.clone() : Product();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(editing ? 'Editar Produto' : 'Criar Anúncio'),
          centerTitle: true,
          actions: [
            if (editing)
              IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    context.read<ProductManager>().delete(product);
                    Navigator.of(context).pop();
                  })
          ],
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
                      onSaved: (name) => product.name = name,
                    ),
                    Text(
                      'R\$ ${product.basePrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    /*TextFormField(
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
                        if (num.tryParse(price) == null) {
                          return 'Inválido';
                        }
                        return null;
                      },
                      //onSaved: (price) => product.price = price as num,
                    ),*/
                    const Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 8),
                      child: Text(
                        'Descrição',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 16),
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
                      onSaved: (desc) => product.description = desc,
                    ),
                    SizesForm(product),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<Product>(
                      builder: (_, product, __) {
                        return SizedBox(
                          height: 44,
                          child: RaisedButton(
                            color: primaryColor,
                            disabledColor: primaryColor.withAlpha(100),
                            textColor: Colors.white,
                            onPressed: !product.loading
                                ? () async {
                                    if (formKey.currentState.validate()) {
                                      formKey.currentState.save();

                                      await product.save();

                                      context
                                          .read<ProductManager>()
                                          .update(product);

                                      Navigator.of(context).pop();
                                    }
                                  }
                                : null,
                            child: product.loading
                                ? const CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  )
                                : const Text(
                                    'Salvar',
                                    style: TextStyle(fontSize: 18),
                                  ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
