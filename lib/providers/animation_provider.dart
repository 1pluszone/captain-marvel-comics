import 'package:flutter/cupertino.dart';

class AnimationProvider with ChangeNotifier {
  //AnimationController _controller;

  AppBarStatus appBarStatus = AppBarStatus.showMarvel;

  changeBarStatus(AppBarStatus status) {
    if (status == AppBarStatus.showMarvel) {
      Future.delayed(Duration(seconds: 2), () {
        print("show marvel animation");
        notifyListeners();
      });
    } else {
      appBarStatus = status;
      notifyListeners();
    }
  }
}

enum AppBarStatus { hidden, showM, showMarvel }
