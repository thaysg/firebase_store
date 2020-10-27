import 'package:firebase_store/common/custom_drawer/custom_drawer.dart';
import 'package:firebase_store/models/home_manager.dart';
import 'package:firebase_store/models/user_manager.dart';
import 'package:firebase_store/screens/home/components/add_section_widget.dart';
import 'package:firebase_store/screens/home/components/section_staggered.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'components/section_carousel.dart';
import 'components/section_list.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: true,
            floating: true,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('TG Store'),
              centerTitle: true,
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  FontAwesomeIcons.shoppingCart,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pushNamed('/cart'),
              ),
              Consumer2<UserManager, HomeManager>(
                builder: (_, userManager, homeManager, __) {
                  if (userManager.adminEnabled) {
                    if (homeManager.editing) {
                      return PopupMenuButton(onSelected: (e) {
                        if (e == 'Salvar') {
                          homeManager.saveEditing();
                        } else {
                          homeManager.discardEditing();
                        }
                      }, itemBuilder: (_) {
                        return ['Salvar', 'Descartar'].map((e) {
                          return PopupMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList();
                      });
                    } else {
                      return IconButton(
                        icon: const Icon(FontAwesomeIcons.edit),
                        onPressed: homeManager.enterEditing,
                      );
                    }
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
          Consumer<HomeManager>(builder: (_, homeManager, __) {
            final List<Widget> children =
                homeManager.sections.map<Widget>((section) {
              switch (section.type) {
                case 'carousel':
                  return SectionCarousel(section);
                case 'List':
                  return SectionList(section);
                case 'Staggered':
                  return SectionStaggered(section);
                default:
                  return Container();
              }
            }).toList();

            if (homeManager.editing) {
              children.add(AddSectionWidget(homeManager));
            }

            return SliverList(
              delegate: SliverChildListDelegate(children),
            );
          })
        ],
      ),
    );
  }
}
