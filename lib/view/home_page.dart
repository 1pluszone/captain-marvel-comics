import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marvel_comics/providers/comics_provider.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

import 'widgets/skewCut_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AfterLayoutMixin<HomePage> {
  final String homeImageUrl =
      "https://terrigen-cdn-dev.marvel.com/content/prod/1x/008cmv_ons_mas_mob_02.jpg";

  final String text1 = "CAROL DANVERS";

  final String text2 = "CAPTAIN MARVEL";

  final String text3 =
      "Carol Danvers becomes one of the univere's most powerful heroes when Earth is caught in the middle of a galactic war between two alien races.";

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
  ScrollController _sc = ScrollController();

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      homeWidgets(),
      comics(),
      Text(
        'Index 2: School',
        style: optionStyle,
      ),
    ];
  }

  @override
  void afterFirstLayout(BuildContext context) {
    provider.getCaptainMarvelComics();

    print("yello");
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        provider.getCaptainMarvelComics();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ComicsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset("asset/images/marvel.svg"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigation(),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }

  Widget homeWidgets() {
    return SingleChildScrollView(
      child: Column(
        children: [
          homeImage(),
          homeDescription(),
          followPane(),
          Divider(),
        ],
      ),
    );
  }

  Widget comics() {
    return Consumer<ComicsProvider>(
      builder: (context, providers, child) => ListView.builder(
        itemCount: providers.comicList.length + 1,
        controller: _sc,
        itemBuilder: (BuildContext context, int index) {
          if (index == providers.comicsList.length) {
            return CircularProgressIndicator();
          }
          return ListTile(
            leading: Text("$index"),
            title: Text(providers.comicsList[index].title),
          );
        },
      ),
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

  Widget homeImage() {
    return Image.network(homeImageUrl);
  }

  Widget homeDescription() {
    return ClipPath(
      clipper: SkewCut(),
      child: Container(
        height: 150,
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Text(
              text1,
              style: style,
            ),
            Text(
              text2,
              style: style,
            ),
            Text(
              text3,
              style: style,
            )
          ],
        ),
      ),
    );
  }

  TextStyle style = TextStyle(color: Colors.white);

  Widget followPane() {
    return Row(
      children: [
        Text("Follow"),
        Spacer(),
        IconButton(
          icon: Icon(Icons.face),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.twenty_three_mp),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
