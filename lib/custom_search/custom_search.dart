import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:movieflix/constants/constants.dart';
import 'package:movieflix/detail_screen/detail_screen.dart';
import 'package:movieflix/movie_card/movie_card_view.dart';
import 'package:movieflix/movie_view_model/movie_view_model.dart';

class CustomSearch extends SearchDelegate{

  final List<MovieViewModel> moviesList;

  CustomSearch(this.moviesList);

  @override
  ThemeData appBarTheme(BuildContext context) {
    var brightness = DynamicTheme.of(context).brightness;
    // TODO: implement appBarTheme
    return ThemeData(
      primaryColor: brightness == Brightness.dark
          ? Colors.blueGrey[900]
          : kPrimaryColor,
      //brightness: DynamicTheme.of(context).brightness,
      textTheme: TextTheme(
          title: TextStyle(color: brightness == Brightness.dark
              ? Colors.white
              : Colors.black54),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final _suggestionList = query.isEmpty
        ? moviesList
        : moviesList
        .where((element) =>
        element.title.toString().toLowerCase().startsWith(query))
        .toList();

    // TODO: implement buildSuggestions
    return ListView.builder(
      itemCount: _suggestionList == null ? 0: _suggestionList.length,
        itemBuilder: (context, index){
      return MovieCard(
        title: _suggestionList[index].title,
        imageURL: _suggestionList[index].posterPath,
        description: _suggestionList[index].overview,
        id: _suggestionList[index].id,
        onPressed: (){

          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
            id: _suggestionList[index].id,
            url: _suggestionList[index].posterPath,
            title: _suggestionList[index].title,
            description: _suggestionList[index].overview,
            releaseDate: _suggestionList[index].releaseDate,
          )));
        },
      );
    });
  }

}