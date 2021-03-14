import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:marvel_comics/models/by_character_model.dart';
import 'package:marvel_comics/resources/network/api_calls.dart';

class ComicsProvider with ChangeNotifier {
  CaptainMarvelComic captainMarvel = new CaptainMarvelComic();

  List<Results> comicsList = [];

  List<Results> get comicList => comicsList;

  void getCaptainMarvelComics() async {
    print(comicsList.length);
    final response = await ApiCalls().getComics(comicsList.length);
    final responseData = json.decode(response.body);
    print(responseData);
    captainMarvel = CaptainMarvelComic.fromJson(responseData);
    for (Results result in captainMarvel.data.results) {
      comicsList.add(result);
    }

    notifyListeners();
  }
}
