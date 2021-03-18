import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marvel_comics/providers/animation_provider.dart';
import 'package:marvel_comics/providers/comics_provider.dart';
import 'package:marvel_comics/view/comics_widget.dart';
import 'package:marvel_comics/view/widgets/sliding_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

import 'home_widget.dart';
import 'widgets/skewCut_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AfterLayoutMixin<HomePage>, SingleTickerProviderStateMixin {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  ComicsProvider provider;
  AnimationProvider animationProvider;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[];

  AnimationController _controller;
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      HomeWidget(),
      ComicsWidget(),
      Text(
        'Index 2: School',
        style: optionStyle,
      ),
    ];

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    provider.getCaptainMarvelComics();
    provider.getCaptainMarvelComicsOnly();
  }

  Widget mLogo;
  slidingAppBar() {
    if (animationProvider.appBarStatus == AppBarStatus.hidden) {
      mLogo = SvgPicture.asset("asset/images/m.svg");
      _controller.reverse();
      return PreferredSize(
          preferredSize: Size.fromHeight(50), child: appBarWidget());
    } else if (animationProvider.appBarStatus == AppBarStatus.showM) {
      mLogo = SvgPicture.asset("asset/images/m.svg");

      _controller.forward();
      return PreferredSize(
          preferredSize: Size.fromHeight(50), child: appBarWidget());
    } else {
      return PreferredSize(
          preferredSize: Size.fromHeight(50), child: animatedAppBar());

      //AppBarStatus.showMarvel
      // return appBarWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ComicsProvider>(context);
    animationProvider = Provider.of<AnimationProvider>(context);

    return Scaffold(
      appBar: slidingAppBar(

          //controller: _controller,
          //visible: _visible,
          //child: AppBar(
          // title: SvgPicture.asset("asset/images/marvel.svg"),
          //centerTitle: true,
          //leading: menuwidget(),
          //actions: [
          //  searchWidget(),
          // ],
          //),
          ),
      bottomNavigationBar: bottomNavigation(),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }

  BottomNavigationBar bottomNavigation() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Comics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Comics Issues',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget appBarWidget() {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset.zero, end: Offset(0, -1)).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
      ),
      child: appBar(),
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
}
