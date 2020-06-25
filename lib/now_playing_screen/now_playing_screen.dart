import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:movieflix/Services/services.dart';
import 'package:movieflix/custom_search/custom_search.dart';
import 'package:movieflix/detail_screen/detail_screen.dart';
import 'package:movieflix/movie_card/movie_card_view.dart';
import 'package:movieflix/notifiers/notifiers.dart';
import 'package:provider/provider.dart';

class NowPlayingScreen extends StatefulWidget {
  @override
  _NowPlayingScreenState createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  static const getNowURL =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed#';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _apiCalling();
  }

  _apiCalling() {
    var _movies = Provider.of<ListManagement>(context, listen: false);
    Service.getNowPlayingMovies(getNowURL).then((movies) {
      _movies.setMovies(movies);
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var _movies = Provider.of<ListManagement>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: _movies.getMovies == null ? null : CustomSearch(),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Theme.of(context).brightness == Brightness.light
                ? Icons.lightbulb_outline
                : Icons.highlight),
            onPressed: () {
              DynamicTheme.of(context).setBrightness(
                  Theme.of(context).brightness == Brightness.light
                      ? Brightness.dark
                      : Brightness.light);
            },
          ),
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: ListView.builder(
          itemCount: _movies.getMovies == null ? 0 : _movies.getMovies.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(_movies.getMovies[index].id.toString()),
              onDismissed: (direction) {
                _movies.getMovies.removeAt(index);
              },
              child: MovieCard(
                title: _movies.getMovies[index].title,
                imageURL: _movies.getMovies[index].posterPath,
                description: _movies.getMovies[index].overview,
                id: _movies.getMovies[index].id,
                isDeleteHidden: false,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        id: _movies.getMovies[index].id,
                        url: _movies.getMovies[index].posterPath,
                        title: _movies.getMovies[index].title,
                        description: _movies.getMovies[index].overview,
                        releaseDate: _movies.getMovies[index].releaseDate,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
