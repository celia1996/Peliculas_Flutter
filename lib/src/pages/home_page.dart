import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/movies_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Películas en cines'),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
            child: Column(
          children: <Widget>[_swiperCards()],
        )));
  }

  Widget _swiperCards() {
    final moviesProvider = new MoviesProvider();
    moviesProvider.getNowInCinemas();

    return CardSwiper(
      movies: [1,2,3,4]
      );
  }
}
