import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:peliculas/src/models/movie_model.dart';

class MoviesProvider {
  String _apiKey = '2c64d73c690b38dc1657735bc3ed8661';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularsPage = 0;

  //stream
  List<Movie> _populars = new List();
  final _popularsStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add;

  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

  void disposeStreams() {
    _popularsStreamController?.close();
  }

  //
  Future<List<Movie>> _processResponse(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }

  Future<List<Movie>> getNowInCinemas() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    return await _processResponse(url);
  }

  Future<List<Movie>> getPopularMovies() async {
    _popularsPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularsPage.toString()
    });

    final response = await _processResponse(url);
    _populars.addAll(response);
    popularsSink(_populars);
    return response;
  }
}
