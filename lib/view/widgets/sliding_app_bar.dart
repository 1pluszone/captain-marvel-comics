import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marvel_comics/providers/animation_provider.dart';
import 'package:marvel_comics/providers/comics_provider.dart';
import 'package:provider/provider.dart';

class SlidingAppBar extends StatefulWidget {
  final AnimationController controller;
  // final bool visible;

  //  @override
  //  final PreferredSizeWidget child;

  @override
  Size get preferredSize => appBar().preferredSize;

  SlidingAppBar({@required this.controller}) : super();

  AnimationProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AnimationProvider>(context);

    if (provider.appBarStatus == AppBarStatus.hidden) {
      mLogo = SvgPicture.asset("asset/images/m.svg");
      controller.reverse();
      return appBarWidget();
    } else if (provider.appBarStatus == AppBarStatus.showM) {
      mLogo = SvgPicture.asset("asset/images/m.svg");

      controller.forward();
      return appBarWidget();
    } else {
      mLogo = SvgPicture.asset("asset/images/m.svg");
      Future.delayed(Duration(seconds: 2), () {
        mLogo = SvgPicture.asset("asset/images/marvel.svg");

        return animatedAppBar();
      });
      //AppBarStatus.showMarvel
      // return appBarWidget();
    }
  }

  Widget appBarWidget() {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset.zero, end: Offset(0, -1)).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
      ),
      child: appBar(),
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

  AppBar appBar() {
    return AppBar(
      title: mLogo,
      centerTitle: true,
      leading: menuwidget(),
      actions: [
        searchWidget(),
      ],
    );
  }

  AppBar animatedAppBar() {
    return AppBar(
      title: AnimatedSwitcher(
          duration: (Duration(milliseconds: 10000)), child: mLogo),
      centerTitle: true,
      leading: menuwidget(),
      actions: [
        searchWidget(),
      ],
    );
  }

  Widget mLogo;
  // final mLogo = SvgPicture.asset("asset/images/m.svg");
  final marvelLogo = SvgPicture.asset("asset/images/marvel.svg");

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
