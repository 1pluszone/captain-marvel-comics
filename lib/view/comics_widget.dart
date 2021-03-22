import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
//import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:marvel_comics/providers/animation_provider.dart';
import 'package:marvel_comics/providers/comics_provider.dart';
import 'package:marvel_comics/view/widgets/each_comic.dart';
import 'package:provider/provider.dart';

import 'widgets/app_bar.dart';

class ComicsWidget extends StatefulWidget {
  @override
  _ComicsWidgetState createState() => _ComicsWidgetState();
}

class _ComicsWidgetState extends State<ComicsWidget>
    with AfterLayoutMixin<ComicsWidget> {
  final _comicsPageController = ScrollController();

  ComicsProvider providers;

  AnimationProvider animationProvider;
  final DateFormat formatter = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    providers = Provider.of<ComicsProvider>(context);
    //animationProvider = Provider.of<AnimationProvider>(context);

    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          color: Colors.white70,
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio(
                value: Sorting.descending,
                groupValue: providers.sortBy,
                onChanged: (Sorting value) {
                  providers.sortByChanged(value);
                },
              ),
              Text("Descending"),
              SizedBox(width: 40),
              Radio(
                value: Sorting.ascending,
                groupValue: providers.sortBy,
                onChanged: (Sorting value) {
                  providers.sortByChanged(value);
                },
              ),
              Text("Ascending"),
            ],
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
              itemCount: providers.comicList.length + 1,
              controller: _comicsPageController,
              itemBuilder: (BuildContext context, int index) {
                if (index == providers.comicsList.length) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                String thumbnailUrl =
                    "${providers.comicsList[index].thumbnail.path}.${providers.comicsList[index].thumbnail.extension}";

                String publishedDate = formatter.format(
                    DateTime.parse(providers.comicList[index].dates[0].date));
                NetworkImage networkImage = NetworkImage(thumbnailUrl);
                return Card(
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.transparent,
                      backgroundImage: networkImage,
                    ),
                    title: Text(
                      providers.comicList[index].title,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(publishedDate),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.redAccent,
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EachComic(
                          publishedDate: publishedDate,
                          eachComic: providers.comicList[index],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _comicsPageController.addListener(() {
      if (_comicsPageController.position.pixels ==
          _comicsPageController.position.maxScrollExtent) {
        providers.getAppearanceComics();
      }

      //TODO. slidable appbar with marvel animation

      // _comicsPageController.addListener(() {
      //   if (_comicsPageController.position.pixels ==
      //       _comicsPageController.position.minScrollExtent) {
      //     animationProvider.changeBarStatus(AppBarStatus.showMarvel);
      //     //showFullLogo();
      //   } else if (_comicsPageController.position.userScrollDirection ==
      //       ScrollDirection.reverse) {
      //     animationProvider.changeBarStatus(AppBarStatus.showM);
      //     //showMLogo();
      //   } else if (_comicsPageController.position.userScrollDirection ==
      //       ScrollDirection.forward) {
      //     animationProvider.changeBarStatus(AppBarStatus.hidden);

      //     //hideLogo();
      //   }
      // });
    });
  }
}
