import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marvel_comics/providers/comics_provider.dart';
import 'package:marvel_comics/view/widgets/comics_widget.dart';
import 'package:marvel_comics/view/widgets/sliding_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

import 'widgets/home_widget.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ComicsProvider>(context);

    return Scaffold(
      appBar: SlidingAppBar(
        controller: _controller,
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
}
