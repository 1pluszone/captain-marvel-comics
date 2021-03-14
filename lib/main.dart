import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/comics_provider.dart';
import 'view/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ComicsProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          //primarySwatch: Colors.red,
          primaryColor: Colors.black,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
