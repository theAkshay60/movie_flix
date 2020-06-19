import 'package:flutter/material.dart';
import 'package:movieflix/constants/constants.dart';
import 'home_screen/home_screen.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

void main() => runApp(MovieFlix());

class MovieFlix extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      //defaultBrightness: Brightness.light,
      data: (brightness) {
        return ThemeData(
          primaryColor: kPrimaryColor,
          //primarySwatch: kPrimaryColor,
          //fontFamily: 'Circular',
          brightness: brightness == Brightness.light
              ? Brightness.light
              : Brightness.dark,
          scaffoldBackgroundColor: brightness == Brightness.dark
              ? Colors.blueGrey[900]
              : Colors.white,
          appBarTheme: AppBarTheme(
            color: brightness == Brightness.dark
                ? Colors.blueGrey[900]
                : kPrimaryColor,
          ),
          cardColor: brightness == Brightness.dark
              ? Colors.black54
              : kPrimaryColor,
          primaryTextTheme: TextTheme(
            title: TextStyle(color: brightness == Brightness.dark
                ? Colors.black54
                : Colors.white,
            ),
          )
        );
      },
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: HomeScreen(),
        );
      },
    );
  }
}
