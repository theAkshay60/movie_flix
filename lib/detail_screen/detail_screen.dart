import 'package:flutter/material.dart';
import 'package:movieflix/constants/constants.dart';

class DetailScreen extends StatelessWidget {
  final String url, title, description;
  final int id;
  final DateTime releaseDate;

  DetailScreen(
      {this.url, this.title, this.description, this.releaseDate, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: kPrimaryColor,
        ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://image.tmdb.org/t/p/w342/$url'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Spacer(),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold,),),
                  SizedBox(height: 10,),
                  Text(description,style: TextStyle(color: Colors.white,fontSize: 16,),),
                  SizedBox(height: 10,),
                  Text('Release Date: $releaseDate',style: TextStyle(color: Colors.white,fontSize: 16,),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
