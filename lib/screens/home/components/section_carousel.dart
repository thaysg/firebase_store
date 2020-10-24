import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_store/models/section.dart';
import 'package:flutter/material.dart';

class SectionCarousel extends StatelessWidget {
  final Section section;

  // ignore: use_key_in_widget_constructors
  const SectionCarousel(
    this.section,
  );

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Container(
      height: 100,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Carousel(
          boxFit: BoxFit.contain,
          images: [
            Image.network(
                'https://cdn3.iconfinder.com/data/icons/geek-3/24/Avengers_marvel_movie_comic_book_action-128.png'),
            Image.network(
                'https://cdn2.iconfinder.com/data/icons/superheroes-set/128/spiderman-128.png'),
            Image.network(
                'https://cdn3.iconfinder.com/data/icons/geek-3/24/Baby_Groot_guardians_of_galaxy_marvel_movie-128.png'),
            Image.network(
                'https://cdn3.iconfinder.com/data/icons/geek-3/24/Captain_America_Shield_marvel_movie_avengers-128.png'),
            Image.network(
                'https://cdn0.iconfinder.com/data/icons/superhero-2/256/Ironman-128.png'),
            Image.network(
                'https://cdn0.iconfinder.com/data/icons/superhero-2/256/Batman-128.png'),
          ],
          dotColor: primaryColor,
          dotBgColor: Colors.transparent,
//      animationCurve: Curves.fastOutSlowIn,
//      animationDuration: Duration(milliseconds: 1000),
          dotSize: 4.0,
          indicatorBgPadding: 2.0,
        ),
      ),
    );
    /*Container(
      height: 150,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Carousel(
          boxFit: BoxFit.contain,
          images: [
            const AssetImage('images/avengers.png'),
            const AssetImage('images/captainamerica.png'),
            const AssetImage('images/spiderman.png'), //Icon by - https://www.iconfinder.com/Franky_
            const AssetImage('images/captainmarvel.png'),
            const AssetImage('images/ironman.png'),
            const AssetImage('images/batman.png'),
            const AssetImage('images/flash.png'),
            const AssetImage('images/supperman.png'),
            const AssetImage('images/hulk.png'),
            const AssetImage('images/hawkeye.png'),
          ],
          dotColor: primaryColor,
          dotBgColor: Colors.transparent,
//      animationCurve: Curves.fastOutSlowIn,
//      animationDuration: Duration(milliseconds: 1000),
          dotSize: 4.0,
          indicatorBgPadding: 2.0,
        ),
      ),
    );*/
  }
}
