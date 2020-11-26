import 'package:firebase_store/models/credit_card.dart';
import 'package:firebase_store/screens/checkout/components/card_back.dart';
import 'package:firebase_store/screens/checkout/components/card_front.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class CreditCardWidget extends StatefulWidget {
  final CreditCard creditCard;

  const CreditCardWidget(this.creditCard);

  @override
  _CreditCardWidgetState createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  final FocusNode numberFocus = FocusNode();

  final FocusNode dateFocus = FocusNode();

  final FocusNode nameFocus = FocusNode();

  final FocusNode cvvFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FlipCard(
              key: cardKey,
              //direction: FlipDirection.HORIZONTAL,
              speed: 700,
              flipOnTouch: false,
              front: CardFront(
                creditCard: widget.creditCard,
                numberFocus: numberFocus,
                dateFocus: dateFocus,
                nameFocus: nameFocus,
                finished: () {
                  cardKey.currentState.toggleCard();
                  cvvFocus.requestFocus();
                },
              ),
              back: CardBack(
                creditCard: widget.creditCard,
                cvvFocus: cvvFocus,
              )),
          FlatButton(
            onPressed: () {
              cardKey.currentState.toggleCard();
            },
            textColor: Colors.white,
            padding: EdgeInsets.zero,
            child: const Text('Virar cartão'),
          )
        ],
      ),
    );
  }
}
