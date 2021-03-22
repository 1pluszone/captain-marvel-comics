import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marvel_comics/models/by_character_model.dart';
import 'package:marvel_comics/resources/network/api_calls.dart';

class ComicsProvider with ChangeNotifier {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Results> comicsList = [];

  List<Results> captainMarvelOnlyComics = [];

  List<Results> get comicList => comicsList;

  List<Results> get captainMarvelOnlyList => captainMarvelOnlyComics;

  Sorting sortBy = Sorting.ascending;

  void sortByChanged(Sorting sortValue) {
    if (sortBy != sortValue) {
      sortBy = sortValue;
      notifyListeners();
      comicsList.clear();
      getAppearanceComics();
    }
  }

  Future<bool> checkConnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      //no internet available

      print("no internet available");
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("No internet connection detected"),
      ));
      return false;
    }
    return true;
  }

  Future<void> getAppearanceComics() async {
    if (await checkConnection()) {
      try {
        CaptainMarvelComic captainMarvel = new CaptainMarvelComic();

        final response =
            await ApiCalls().getAppearance(comicsList.length, sortBy);
        final responseData = json.decode(response.body);
        print(responseData);
        captainMarvel = CaptainMarvelComic.fromJson(responseData);
        for (Results result in captainMarvel.data.results) {
          comicsList.add(result);
        }
        notifyListeners();
      } catch (e) {
        print("an error occured $e");
        snackBarRecursive("An error occured", getAppearanceComics);
      }
    }
  }

  void snackBarRecursive(String content, Function recall) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(content),
      duration: Duration(seconds: 10),
      action: SnackBarAction(
        label: "Try again",
        onPressed: () => recall,
      ),
    ));
  }

  Future<void> getCaptainMarvelComicsOnly() async {
    try {
      CaptainMarvelComic captainMarvelComic = new CaptainMarvelComic();
      final response = await ApiCalls()
          .getCaptainMarvelComicsOnly(captainMarvelOnlyComics.length);
      final responseData = json.decode(response.body);
      print(responseData);
      captainMarvelComic = CaptainMarvelComic.fromJson(responseData);
      for (Results result in captainMarvelComic.data.results) {
        captainMarvelOnlyComics.add(result);
      }
      notifyListeners();
    } catch (e) {
      snackBarRecursive("An error occured", getCaptainMarvelComicsOnly);
    }
  }
}

enum Sorting { ascending, descending }
