import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:marvel_comics/providers/animation_provider.dart';
import 'package:marvel_comics/providers/comics_provider.dart';
import 'package:marvel_comics/view/widgets/each_comic.dart';
import 'package:provider/provider.dart';

class ComicsWidget extends StatefulWidget {
  @override
  _ComicsWidgetState createState() => _ComicsWidgetState();
}

class _ComicsWidgetState extends State<ComicsWidget>
    with AfterLayoutMixin<ComicsWidget> {
  final _comicsPageController = ScrollController();

  ComicsProvider provider;

  AnimationProvider animationProvider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ComicsProvider>(context);
    animationProvider = Provider.of<AnimationProvider>(context);
    return Consumer<ComicsProvider>(
      builder: (context, providers, child) => ListView.builder(
          itemCount: providers.comicList.length + 1,
          controller: _comicsPageController,
          itemBuilder: (BuildContext context, int index) {
            if (index == providers.comicsList.length) {
              return Center(child: CircularProgressIndicator());
            }
            String url =
                "${providers.comicsList[index].images[0].path}.${providers.comicsList[index].images[0].extension}";
            Widget comicImage = Image.network(url);
            return ListTile(
              title: comicImage,
              subtitle: Text(providers.comicList[index].title),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EachComic(
                    comicImage: comicImage,
                    eachComic: providers.comicList[index],
                  ),
                ),
              ),
            );
          }),

      // new StaggeredGridView.countBuilder(
      //     controller: _comicsPageController,
      //     crossAxisCount: 4,
      //     itemCount: providers.comicList.length + 1,
      //     staggeredTileBuilder: (int index) =>
      //         new StaggeredTile.count(2, index.isEven ? 2 : 1),
      //     mainAxisSpacing: 4.0,
      //     crossAxisSpacing: 4.0,
      //     itemBuilder: (BuildContext context, int index) {
      //       if (index == providers.comicList.length) {
      //         return Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       }
      //       String url =
      //           "${providers.comicsList[index].images[0].path}.${providers.comicsList[index].images[0].extension}";
      //       return new Card(

      //           elevation: 10,
      //           child: new Center(
      //             child: new Column(
      //               children: [
      //                 Image.network(url),
      //                 Text(providers.comicList[index].title),
      //               ],
      //             ),
      //           ));
      //     })
    );
  }

  // final items = List<String>.generate(10000, (i) => "Item $i");

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
