import 'package:flutter/material.dart';
import 'package:marvel_comics/providers/animation_provider.dart';
import 'package:provider/provider.dart';

import 'providers/comics_provider.dart';
import 'view/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ComicsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AnimationProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          iconTheme: IconThemeData(color: Colors.black54),
          textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            headline2: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            headline3: TextStyle(
              fontSize: 15.0,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            headline5: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
              //fontWeight: FontWeight.bold,
            ),
            headline6: TextStyle(
                fontSize: 15.0,
                fontStyle: FontStyle.italic,
                color: Colors.white),
            bodyText2: TextStyle(
                //fontSize: 14.0, fontFamily: 'Hind', color: Colors.white),
                fontSize: 14.0,
                color: Colors.white),
            bodyText1: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}
