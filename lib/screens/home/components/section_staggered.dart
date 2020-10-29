import 'package:firebase_store/models/home_manager.dart';
import 'package:firebase_store/models/section.dart';
import 'package:firebase_store/screens/home/components/add_tile_widget.dart';
import 'package:firebase_store/screens/home/components/item_tile.dart';
import 'package:firebase_store/screens/home/components/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class SectionStaggered extends StatelessWidget {
  final Section section;

  // ignore: use_key_in_widget_constructors
  const SectionStaggered(this.section);

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
            Consumer<Section>(builder: (_, section, __) {
              return StaggeredGridView.countBuilder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                crossAxisCount: 4,
                itemCount: homeManager.editing
                    ? section.items.length + 1
                    : section.items.length,
                itemBuilder: (_, index) {
                  if (index < section.items.length) {
                    return ItemTile(section.items[index]);
                  } else {
                    return AddTileWidget();
                  }
                },
                staggeredTileBuilder: (index) =>
                    StaggeredTile.count(2, index.isEven ? 2 : 2),
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              );
            })
          ],
        ),
      ),
    );
  }
}
