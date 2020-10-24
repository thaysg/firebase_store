import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {

  final String initialText;

  // ignore: use_key_in_widget_constructors
  const SearchDialog(this.initialText);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 1,
            left: 6,
            right: 6,
            child: Card(
              child: TextFormField(
                initialValue: initialText,
                textInputAction: TextInputAction.search,
                autofocus: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  prefixIcon: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: (){
                        Navigator.of(context).pop();
                      }
                  )
                ),
                onFieldSubmitted: (text){
                  Navigator.of(context).pop(text);
                },
              ),
            )
        )
      ],
    );
  }
}
