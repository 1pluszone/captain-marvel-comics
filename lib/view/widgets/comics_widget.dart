import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:marvel_comics/providers/animation_provider.dart';
import 'package:marvel_comics/providers/comics_provider.dart';
import 'package:provider/provider.dart';

Widget comics() {}

class ComicsWidget extends StatelessWidget {
  final _comicsPageController = ScrollController();

  ComicsProvider provider;
  AnimationProvider animationProvider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ComicsProvider>(context);
    animationProvider = Provider.of<AnimationProvider>(context);
    // return Consumer<ComicsProvider>(
    //   builder: (context, providers, child) => ListView.builder(
    //     itemCount: providers.comicList.length + 1,
    //     controller: _comicsPageController,
    //     itemBuilder: (BuildContext context, int index) {
    //       if (index == providers.comicsList.length) {
    //         return Center(child: CircularProgressIndicator());
    //       }
    //       return ListTile(
    //         leading: Text("$index"),
    //         title: Text(providers.comicsList[index].title),
    //       );
    //     },
    //   ),
    // );
    return ListView.builder(
      itemCount: items.length,
      controller: _comicsPageController,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${items[index]}'),
        );
      },
    );
  }

  final items = List<String>.generate(10000, (i) => "Item $i");

  @override
  void afterFirstLayout(BuildContext context) {
    _comicsPageController.addListener(() {
      if (_comicsPageController.position.pixels ==
          _comicsPageController.position.maxScrollExtent) {
        provider.getCaptainMarvelComics();
      }
      _comicsPageController.addListener(() {
        if (_comicsPageController.position.pixels ==
            _comicsPageController.position.minScrollExtent) {
          animationProvider.changeBarStatus(AppBarStatus.showMarvel);
          //showFullLogo();
        } else if (_comicsPageController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          animationProvider.changeBarStatus(AppBarStatus.showM);
          //showMLogo();
        } else if (_comicsPageController.position.userScrollDirection ==
            ScrollDirection.forward) {
          animationProvider.changeBarStatus(AppBarStatus.hidden);

          //hideLogo();
        }
      });
    });
  }
}
