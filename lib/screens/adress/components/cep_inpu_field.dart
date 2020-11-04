import 'package:brasil_fields/brasil_fields.dart';
import 'package:firebase_store/common/custom_icon_button/custom_icon_button.dart';
import 'package:firebase_store/models/address.dart';
import 'package:firebase_store/models/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class CepInputField extends StatefulWidget {
  final Address address;

  // ignore: use_key_in_widget_constructors
  const CepInputField(this.address);

  @override
  _CepInputFieldState createState() => _CepInputFieldState();
}

class _CepInputFieldState extends State<CepInputField> {
  final TextEditingController cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final primaryColor = Theme.of(context).primaryColor;

    if (widget.address.zipCode == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            enabled: !cartManager.loading,
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
          if (cartManager.loading)
            LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(primaryColor),
              backgroundColor: Colors.transparent,
            ),
          SizedBox(
            height: 44,
            child: RaisedButton(
              onPressed: !cartManager.loading
                  ? () async {
                      if (Form.of(context).validate()) {
                        try {
                          await context
                              .read<CartManager>()
                              .getAddress(cepController.text);
                        } catch (e) {
                          Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text('$e')));
                        }
                      }
                    }
                  : null,
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
                'CEP: ${widget.address.zipCode}',
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
