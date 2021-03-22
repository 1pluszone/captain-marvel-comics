import 'package:flutter/material.dart';
import 'package:marvel_comics/models/by_character_model.dart';
import 'package:intl/intl.dart';

class EachComic extends StatelessWidget {
  final Results eachComic;
  final String publishedDate;

  EachComic({@required this.eachComic, @required this.publishedDate});

  final List<Widget> childrenList = [];
  final List<Widget> childrenListPart2 = [];

  @override
  Widget build(BuildContext context) {
    String url = "${eachComic.images[0].path}.${eachComic.images[0].extension}";

    childrenList.add(
      FadeInImage.assetNetwork(
          width: double.infinity,
          placeholder: "asset/images/loading.gif",
          image: url),
    );
    childrenList.add(
      Center(
          child: Text(eachComic.title,
              style: Theme.of(context).textTheme.headline1)),
    );
    childrenList.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Text(
        eachComic.description ?? "No description included",
        style: Theme.of(context).textTheme.headline5,
      )),
    ));

    creators(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.start,
            children: childrenList,
          ),
        ),
      ),
    );
  }

  void creators(BuildContext context) {
    childrenList.add(Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Published:", style: Theme.of(context).textTheme.headline5),
          Text(publishedDate, style: Theme.of(context).textTheme.bodyText1),
          // SizedBox(height: 10),
        ],
      ),
    ));

    for (Items creators in eachComic.creators.items) {
      childrenList.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(creators.role),
            Text(creators.name),
          ],
        ),
      ));
    }
    childrenList.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text("price:"),
          Text("\$${eachComic.prices[0].price.toString()}"),
        ],
        //
      ),
    ));
  }
}
