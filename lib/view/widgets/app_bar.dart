import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

marvelAppBar() {
  return AppBar(
    title: SvgPicture.asset("asset/images/marvel.svg"),
    centerTitle: true,
    leading: menuwidget(),
    actions: [
      searchWidget(),
    ],
  );
}

Widget menuwidget() {
  return IconButton(
    icon: Icon(Icons.menu),
    onPressed: () {},
  );
}

Widget searchWidget() {
  return IconButton(
    icon: Icon(Icons.search),
    onPressed: () {},
  );
}
