import 'package:firebase_store/models/home_manager.dart';
import 'package:firebase_store/models/section.dart';
import 'package:firebase_store/screens/home/components/add_tile_widget.dart';
import 'package:firebase_store/screens/home/components/item_tile.dart';
import 'package:firebase_store/screens/home/components/section_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionList extends StatelessWidget {
  final Section section;

  // ignore: use_key_in_widget_constructors
  const SectionList(this.section);

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();

    return ChangeNotifierProvider.value(
      value: section,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(),
            SizedBox(
              height: 170,
              child: Consumer<Section>(builder: (_, section, __) {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    if (index < section.items.length) {
                      return ItemTile(section.items[index]);
                    } else {
                      return ItemTileWidget();
                    }
                  },
                  separatorBuilder: (_, __) => const SizedBox(
                    width: 4,
                  ),
                  itemCount: homeManager.editing
                      ? section.items.length + 1
                      : section.items.length,
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
