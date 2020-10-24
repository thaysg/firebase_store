import 'package:firebase_store/models/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {

  final IconData iconData;
  final String title;
  final int page;

  const DrawerTile({Key key, this.iconData, this.title, this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final curPage = context.watch<PageManager>().page;

    return InkWell(
      onTap: (){
        context.read<PageManager>().setPage(page);
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData,
                size: 32,
                color: curPage == page ? Colors.black : Colors.white60
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                  color: curPage == page ? Colors.black : Colors.white60
              ),
            )
          ],
        ),
      ),
    );
  }
}
