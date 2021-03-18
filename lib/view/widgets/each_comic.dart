import 'package:flutter/material.dart';
import 'package:marvel_comics/models/by_character_model.dart';

class EachComic extends StatelessWidget {
  final Results eachComic;
  final Widget comicImage;

  EachComic({@required this.eachComic, @required this.comicImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          comicImage,
          Text(eachComic.title ?? ""),
          Text(eachComic.description ?? "No description included"),
        ],
      ),
    );
  }
}
