import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marvel_comics/providers/animation_provider.dart';
import 'package:marvel_comics/providers/comics_provider.dart';
import 'package:provider/provider.dart';

class SlidingAppBar extends PreferredSize {
//class SlidingAppBar {
  final AnimationController controller;
  // final bool visible;

  //  @override
  //  final PreferredSizeWidget child;

  //  @override
  //  Size get preferredSize => child.preferredSize;

  SlidingAppBar({@required this.controller}) : super();

  AnimationProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AnimationProvider>(context);

    if (provider.appBarStatus == AppBarStatus.hidden) {
      controller.reverse();
      return appBarWidget();
    } else if (provider.appBarStatus == AppBarStatus.showM) {
      controller.forward();
      return appBarWidget();
    } else {
      //AppBarStatus.showMarvel
      return SizedBox();
    }
  }

  Widget appBarWidget() {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset.zero, end: Offset(0, -1)).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
      ),
      child: AppBar(
        title: SvgPicture.asset("asset/images/marvel.svg"),
        centerTitle: true,
        leading: menuwidget(),
        actions: [
          searchWidget(),
        ],
      ),
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
}
