import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:marvel_comics/models/by_character_model.dart';
import 'package:marvel_comics/resources/network/api_calls.dart';

class ComicsProvider with ChangeNotifier {
  CaptainMarvelComic captainMarvel = new CaptainMarvelComic();

  List<Results> comicsList = [];

  List captainMarvelOnly = [];

  List<Results> get comicList => comicsList;

  List get captainMarvelsOnly => captainMarvelOnly;

  Future<void> getCaptainMarvelComics() async {
    //rename to captainmarvelappearance
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

  Future<void> getCaptainMarvelComicsOnly() async {
    final response = await ApiCalls().getCaptainMarvelComics();
    final responseData = json.decode(response.body);
    print(responseData);
  }
}
