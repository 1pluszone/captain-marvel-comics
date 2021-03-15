import 'package:flutter/cupertino.dart';

class AnimationProvider with ChangeNotifier {
  //AnimationController _controller;

  AppBarStatus appBarStatus = AppBarStatus.showMarvel;

  changeBarStatus(AppBarStatus status) {
    appBarStatus = status;
    notifyListeners();
  }
}

enum AppBarStatus { hidden, showM, showMarvel }
