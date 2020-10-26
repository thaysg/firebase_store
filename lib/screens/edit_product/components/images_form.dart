import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_store/models/product.dart';
import 'package:firebase_store/screens/edit_product/components/image_source_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImagesForm extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ImagesForm(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: List.from(product.images),
      validator: (images) {
        if (images.isEmpty) {
          return 'Insira ao menos uma imagem';
        }
        return null;
      },
      onSaved: (images) => product.newImages = images,
      builder: (state) {
        void onImageSelected(File file) {
          state.value.add(file);
          state.didChange(state.value);
          // ignore: unnecessary_statements
          Navigator.of(context).pop;
        }

        return Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                images: state.value.map<Widget>((image) {
                  return Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      if (image is String)
                        Image.network(
                          image,
                          fit: BoxFit.cover,
                        )
                      else
                        Image.file(
                          image as File,
                          fit: BoxFit.cover,
                        ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(FontAwesomeIcons.minusCircle),
                          color: Colors.red,
                          onPressed: () {
                            state.value.remove(image);
                            state.didChange(state.value);
                          },
                        ),
                      )
                    ],
                  );
                }).toList()
                  ..add(Material(
                    color: Colors.grey[100],
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(FontAwesomeIcons.camera),
                            color: Theme.of(context).primaryColor,
                            iconSize: 70,
                            onPressed: () {
                              if (Platform.isAndroid) {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (_) => ImageSourceSheet(
                                          onImageSelected: onImageSelected,
                                        ));
                              } else {
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (_) => ImageSourceSheet(
                                          onImageSelected: onImageSelected,
                                        ));
                              }
                            },
                          ),
                          const Text(
                            'Adicionar Imagens',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  )),
                dotSize: 4,
                dotBgColor: Colors.transparent,
                dotColor: Theme.of(context).primaryColor,
                autoplay: false,
                dotSpacing: 15,
              ),
            ),
            if (state.hasError)
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 16, left: 16),
                child: Text(
                  state.errorText,
                  style: TextStyle(color: Colors.red.shade900, fontSize: 12),
                ),
              )
          ],
        );
      },
    );
  }
}
