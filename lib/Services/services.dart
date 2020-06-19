import 'package:movieflix/movie_model/now_playing.dart';
import 'package:http/http.dart' as http;
import 'package:movieflix/movie_model/top_rated.dart';
import 'package:movieflix/movie_view_model/movie_view_model.dart';

class Service {

  static Future<List<MovieViewModel>> getNowPlayingMovies(String url) async {
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = nowPlayingFromJson(response.body);
        List<MovieViewModel> movieList = jsonResponse.results
            .map((item) => MovieViewModel(
                popularity: item.popularity,
                voteCount: item.voteCount,
                video: item.video,
                posterPath: item.posterPath,
                id: item.id,
                adult: item.adult,
                backdropPath: item.backdropPath,
                originalLanguage: item.originalLanguage,
                originalTitle: item.originalTitle,
                genreIds: item.genreIds,
                title: item.title,
                voteAverage: item.voteAverage,
                overview: item.overview,
                releaseDate: item.releaseDate))
            .toList();
        return movieList;
      } else {
        return List<MovieViewModel>();
      }
    } catch (e) {
      return List<MovieViewModel>();
    }
  }

  static Future<List<MovieViewModel>> getTopRatedMovies(String url) async {
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = topRatedFromJson(response.body);
        List<MovieViewModel> movieList = jsonResponse.results
            .map((item) => MovieViewModel(
            popularity: item.popularity,
            voteCount: item.voteCount,
            video: item.video,
            posterPath: item.posterPath,
            id: item.id,
            adult: item.adult,
            backdropPath: item.backdropPath,
            //originalLanguage: item.originalLanguage,
            originalTitle: item.originalTitle,
            genreIds: item.genreIds,
            title: item.title,
            voteAverage: item.voteAverage,
            overview: item.overview,
            releaseDate: item.releaseDate))
            .toList();
        return movieList;
      } else {
        return List<MovieViewModel>();
      }
    } catch (e) {
      return List<MovieViewModel>();
    }
  }

}
