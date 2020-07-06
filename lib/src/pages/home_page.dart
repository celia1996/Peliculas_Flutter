import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/movies_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();

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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperCards(),
            _footer(context)
            ],
        )));
  }

  Widget _swiperCards() {
    return FutureBuilder(
      future: moviesProvider.getNowInCinemas(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(movies: snapshot.data);
        }else{
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
              )
              );
        }
      },
    );
  }

  Widget _footer( BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text('Populares', style: Theme.of(context).textTheme.subtitle2),
          FutureBuilder(
            future: moviesProvider.getPopularMovies(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              
              snapshot.data?.forEach((movie) => print(movie.title));
              return Container() ;
            },
          ),
        ],
      )
    );
  }
}
