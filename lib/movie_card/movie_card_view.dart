import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieflix/constants/constants.dart';

class MovieCard extends StatelessWidget {
  final String title, description, imageURL;
  final int id;
  final Function onPressed;
  final bool isDeleteHidden;
  final Function onDeletePress;

  const MovieCard({this.title,
    this.description,
    this.imageURL,
    this.id,
    this.onPressed,
    this.isDeleteHidden, this.onDeletePress});

  @override
  Widget build(BuildContext context) {
    var brightness = DynamicTheme.of(context).brightness;
    return InkWell(
      onTap: onPressed,
      child: Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: brightness == Brightness.dark
                  ? Colors.black54
                  : kPrimaryColor,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Row(
            children: <Widget>[
              FadeInImage.assetNetwork(
                placeholder: 'assets/placeholder.png',
                image: 'https://image.tmdb.org/t/p/w342/$imageURL',
                height: 100,
                width: 60,
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        //color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 2,
                      style: TextStyle(
                        //color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isDeleteHidden,
                child: IconButton(
                    icon: Icon(Icons.delete), onPressed: onDeletePress),
              ),
            ],
          )),
    );
  }
}

//'https://image.tmdb.org/t/p/w342/$imageURL'

//Card(
//color: kPrimaryColor,
//child: ListTile(
//leading: Hero(
//tag: id,
//child: Image.network('https://image.tmdb.org/t/p/w342/$imageURL')),
//title: Text(title),
//subtitle: Text(description,),
//onTap: onPressed,
//),
//);
