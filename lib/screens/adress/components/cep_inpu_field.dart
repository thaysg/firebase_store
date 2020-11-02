import 'package:brasil_fields/brasil_fields.dart';
import 'package:firebase_store/common/custom_icon_button/custom_icon_button.dart';
import 'package:firebase_store/models/address.dart';
import 'package:firebase_store/models/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class CepInputField extends StatelessWidget {
  final Address address;

  final cepController = TextEditingController();

  // ignore: use_key_in_widget_constructors
  CepInputField(this.address);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    if (address.zipCode == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: cepController,
            decoration: const InputDecoration(
                isDense: true, labelText: 'CEP', hintText: '14.780-000'),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter()
            ],
            keyboardType: TextInputType.number,
            validator: (cep) {
              if (cep.isEmpty) {
                return 'Campo Obrigatótio';
              } else if (cep.length != 10) return 'CEP Inválido';
              return null;
            },
          ),
          const SizedBox(
            height: 7,
          ),
          SizedBox(
            height: 44,
            child: RaisedButton(
              onPressed: () {
                if (Form.of(context).validate()) {
                  context.read<CartManager>().getAddress(cepController.text);
                }
              },
              color: primaryColor,
              disabledColor: primaryColor.withAlpha(100),
              textColor: Colors.white,
              child: const Text(
                'Buscar CEP',
                style: TextStyle(fontSize: 18),
              ),
            ),
          )
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'CEP: ${address.zipCode}',
                style:
                    TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
              ),
            ),
            CustomIConButtton(
              iconData: Icons.edit,
              color: primaryColor,
              onTap: () {
                context.read<CartManager>().removeAddress();
              },
            )
          ],
        ),
      );
    }
  }
}
