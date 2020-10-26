import 'package:firebase_store/common/custom_icon_button/custom_icon_button.dart';
import 'package:firebase_store/models/item_size.dart';
import 'package:firebase_store/models/product.dart';
import 'package:firebase_store/screens/edit_product/components/edit_item_size.dart';
import 'package:flutter/material.dart';

class SizesForm extends StatelessWidget {
  final Product product;

  // ignore: use_key_in_widget_constructors
  const SizesForm(this.product);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormField<List<ItemSize>>(
          initialValue: product.sizes,
          validator: (sizes) {
            if (sizes.isEmpty) {
              return 'Insira um Tamanho';
            }
            return null;
          },
          builder: (state) {
            return Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Tamanhos',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    CustomIConButtton(
                      iconData: Icons.add,
                      color: Colors.black,
                      onTap: () {
                        state.value.add(ItemSize());
                        state.didChange(state.value);
                      },
                    )
                  ],
                ),
                Column(
                  children: state.value.map((size) {
                    return EditItemSize(
                      key: ObjectKey(size),
                      size: size,
                      onRemove: () {
                        state.value.remove(size);
                        state.didChange(state.value);
                      },
                      onMoveUp: size != state.value.first
                          ? () {
                              final index = state.value.indexOf(size);
                              state.value.remove(size);
                              state.value.insert(index - 1, size);
                              state.didChange(state.value);
                            }
                          : null,
                      onMoveDown: size != state.value.last
                          ? () {
                              final index = state.value.indexOf(size);
                              state.value.remove(size);
                              state.value.insert(index + 1, size);
                              state.didChange(state.value);
                            }
                          : null,
                    );
                  }).toList(),
                ),
                if (state.hasError)
                  Container(
                    alignment: Alignment.topCenter,
                    child: Text(
                      state.errorText,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  )
              ],
            );
          },
        ),
      ],
    );
  }
}
