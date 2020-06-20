import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:movieflix/constants/constants.dart';
import 'package:movieflix/now_playing_screen/now_playing_screen.dart';
import 'package:movieflix/top_rated_screen/top_rated_screen.dart';

class HomeScreen extends StatefulWidget {
  bool darkThemEnabled;

  HomeScreen({this.darkThemEnabled});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final tabs = [NowPlayingScreen(), TopRateScreen()];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var brightness = DynamicTheme.of(context).brightness;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: brightness == Brightness.dark
            ? Colors.blueGrey[900]
            : kPrimaryColor,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        showSelectedLabels: true,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_filled),
            title: Text('Now Playing'),
//            backgroundColor: brightness == Brightness.dark
//                ? Colors.blueGrey[900]
//                : kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Top Rated'),
            //backgroundColor: kPrimaryColor,
          ),
        ],
      ),
      body: tabs[_currentIndex],
    );
  }
}
