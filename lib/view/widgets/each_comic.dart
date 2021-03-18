import 'package:flutter/material.dart';
import 'package:marvel_comics/models/by_character_model.dart';
import 'package:intl/intl.dart';

class EachComic extends StatelessWidget {
  final Results eachComic;
  final Widget comicImage;

  EachComic({@required this.eachComic, @required this.comicImage});

  final List<Widget> childrenList = [];
  final DateFormat formatter = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    String url = "${eachComic.images[0].path}.${eachComic.images[0].extension}";

    childrenList.add(Text(eachComic.title ?? ""));
    childrenList.add(Image.network(url));
    childrenList.add(Text(eachComic.description ?? "No description included"));
    childrenList.add(Text("Published:"));
    childrenList
        .add(Text(formatter.format(DateTime.parse(eachComic.dates[0].date))));
    creators();
    childrenList.add(Wrap(
      children: [
        Text("price: \$"),
        Text(eachComic.prices[0].price.toString()),
      ],
      //
    ));

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: childrenList,
        ),
      ),
    );
  }

  void creators() {
    for (Items creators in eachComic.creators.items) {
      childrenList.add(Column(
        children: [
          Text(creators.role),
          Text(creators.name),
        ],
      ));
    }
  }
}
