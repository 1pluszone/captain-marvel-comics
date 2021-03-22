import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';
import 'package:marvel_comics/providers/comics_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/each_comic.dart';

class CaptainMarvelSeries extends StatefulWidget {
  @override
  _CaptainMarvelSeriesState createState() => _CaptainMarvelSeriesState();
}

class _CaptainMarvelSeriesState extends State<CaptainMarvelSeries>
    with AfterLayoutMixin<CaptainMarvelSeries> {
  final _comicsPageController = ScrollController();
  ComicsProvider _provider;
  final DateFormat formatter = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<ComicsProvider>(context);
    return ListView.builder(
        itemCount: _provider.captainMarvelOnlyList.length + 1,
        controller: _comicsPageController,
        itemBuilder: (BuildContext context, int index) {
          if (index == _provider.captainMarvelOnlyList.length) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          String thumbnailUrl =
              "${_provider.captainMarvelOnlyList[index].thumbnail.path}.${_provider.captainMarvelOnlyList[index].thumbnail.extension}";

          String publishedDate = formatter.format(DateTime.parse(
              _provider.captainMarvelOnlyList[index].dates[0].date));
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
                _provider.captainMarvelOnlyList[index].title,
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
                    eachComic: _provider.captainMarvelOnlyList[index],
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _provider.getCaptainMarvelComicsOnly();
    _comicsPageController.addListener(() {
      if (_comicsPageController.position.pixels ==
          _comicsPageController.position.maxScrollExtent) {
        _provider.getCaptainMarvelComicsOnly();
      }
    });
  }
}
