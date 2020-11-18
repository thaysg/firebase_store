import 'package:firebase_store/common/custom_icon_button/custom_icon_button.dart';
import 'package:firebase_store/models/stores.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreCard extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const StoreCard(this.store);

  final Store store;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    Color colorForStatus(StoreStatus status) {
      switch (status) {
        case StoreStatus.closed:
          return Colors.red;
        case StoreStatus.open:
          return Colors.green;
        case StoreStatus.closing:
          return Colors.orange;
        default:
          return Colors.green;
      }
    }

    Future<void> openPhone() async {
      if (await canLaunch('tel:${store.cleanPhone}')) {
        launch('tel:${store.cleanPhone}');
      } else {
        Scaffold.of(context).showSnackBar(const SnackBar(
          content: Text('Esta função não está disponível neste dispositivo'),
          backgroundColor: Colors.red,
        ));
      }
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          // ignore: sized_box_for_whitespace
          Container(
            height: 160,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.network(
                  store.image,
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(8))),
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      store.statusText,
                      style: TextStyle(
                        color: colorForStatus(store.status),
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 140,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        store.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        store.addressText,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        store.openingText,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CustomIConButtton(
                      iconData: Icons.map,
                      color: primaryColor,
                      onTap: () {},
                    ),
                    CustomIConButtton(
                      iconData: Icons.phone,
                      color: primaryColor,
                      onTap: openPhone,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
