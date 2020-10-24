import 'package:firebase_store/common/custom_icon_button/custom_icon_button.dart';
import 'package:firebase_store/models/item_size.dart';
import 'package:flutter/material.dart';

class EditItemSize extends StatelessWidget {
  final ItemSize size;
  final VoidCallback onRemove;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  const EditItemSize(
      {Key key, this.size, this.onRemove, this.onMoveUp, this.onMoveDown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 30,
          child: TextFormField(
              initialValue: size.name,
              decoration:
                  const InputDecoration(labelText: 'Título', isDense: true),
              validator: (name) {
                if (name.isEmpty) return 'Inválido';
                return null;
              },
              onChanged: (name) => size.name = name),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.stock?.toString(),
            decoration:
                const InputDecoration(labelText: 'Estoque', isDense: true),
            validator: (stock) {
              if (int.tryParse(stock) == null) {
                return 'Inválido';
              }
              return null;
            },
            onChanged: (stock) => size.stock = int.tryParse(stock),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 40,
          child: TextFormField(
            initialValue: size.price?.toStringAsFixed(2),
            decoration: const InputDecoration(
                labelText: 'Preço', prefixText: 'R\$ ', isDense: true),
            validator: (price) {
              if (num.tryParse(price) == null) {
                return 'Inválido';
              }
              return null;
            },
            onChanged: (price) => size.price = num.tryParse(price),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        CustomIConButtton(
          iconData: Icons.remove,
          color: Colors.red,
          onTap: onRemove,
        ),
        CustomIConButtton(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
          onTap: onMoveUp,
        ),
        CustomIConButtton(
          iconData: Icons.arrow_drop_down,
          color: Colors.black,
          onTap: onMoveDown,
        ),
      ],
    );
  }
}
