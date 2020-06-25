import 'package:flutter/cupertino.dart';
import 'package:movieflix/movie_view_model/movie_view_model.dart';

class ListManagement extends ChangeNotifier {
  List<MovieViewModel> _movies;

  List<MovieViewModel> get getMovies => _movies;

  void setMovies(List<MovieViewModel> listMovie) {
    _movies = listMovie;
    notifyListeners();
  }

  void updateMovies(int index) {
    _movies.removeWhere((movie) => movie.id == index);
    notifyListeners();
  }
}
