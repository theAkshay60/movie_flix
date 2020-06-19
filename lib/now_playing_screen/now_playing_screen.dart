import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:movieflix/Services/services.dart';
import 'package:movieflix/constants/constants.dart';
import 'package:movieflix/custom_search/custom_search.dart';
import 'package:movieflix/detail_screen/detail_screen.dart';
import 'package:movieflix/movie_card/movie_card_view.dart';
import 'package:movieflix/movie_view_model/movie_view_model.dart';

class NowPlayingScreen extends StatefulWidget {
  @override
  _NowPlayingScreenState createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  static const getNowURL =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed#';

  String searchValue;
  bool isLoading = true;

  List<MovieViewModel> _movieList;
  @override
  void initState() {
    super.initState();
    _apiCalling();
  }

  _apiCalling() {
    Service.getNowPlayingMovies(getNowURL).then((movies) {
      _movieList = movies;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: kPrimaryColor,
          leading: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate:
                _movieList == null ? null : CustomSearch(_movieList),
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
                })
          ],
        ),
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: ListView.builder(
              itemCount: _movieList == null ? 0 : _movieList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(_movieList[index].id.toString()),
                  onDismissed: (direction){
                    setState(() {
                      _movieList.removeAt(index);
                    });
                  },
                  child: MovieCard(
                    title: _movieList[index].title,
                    imageURL: _movieList[index].posterPath,
                    description: _movieList[index].overview,
                    id: _movieList[index].id,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                    id: _movieList[index].id,
                                    url: _movieList[index].posterPath,
                                    title: _movieList[index].title,
                                    description: _movieList[index].overview,
                                    releaseDate: _movieList[index].releaseDate,
                                  )));
                    },
                  ),
                );
              }),
        ));
  }
}
