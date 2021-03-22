import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:marvel_comics/providers/comics_provider.dart';
import 'package:marvel_comics/view/widgets/skewCut_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatelessWidget {
  final _homePageController = ScrollController();

  final String text1 = "CAROL DANVERS";

  final String text2 = "CAPTAIN MARVEL";

  final String text3 =
      "Carol Danvers becomes one of the univere's most powerful heroes when Earth is caught in the middle of a galactic war between two alien races.";
  final String homeImageUrl =
      "https://terrigen-cdn-dev.marvel.com/content/prod/1x/008cmv_ons_mas_mob_02.jpg";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _homePageController,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            homeImage(),
            homeDescription(context),
            followPane(context),
            Divider(
              color: Colors.black54,
            ),
            comicsImageSlider(),
          ],
        ),
      ),
    );
  }

  Widget comicsImageSlider() {
    return Consumer<ComicsProvider>(
      builder: (context, marvelComics, child) =>
          (marvelComics.captainMarvelOnlyComics.isEmpty)
              ? SizedBox()
              : CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 400.0,
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(seconds: 1),
                  ),
                  itemCount: marvelComics.captainMarvelOnlyComics.length,
                  itemBuilder: (BuildContext context, int index) => Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black,
                      child: Image.network(
                          "${marvelComics.comicsList[index].thumbnail.path}.${marvelComics.comicsList[index].thumbnail.extension}")),
                ),
    );
  }

  Widget homeImage() {
    return Image.asset("asset/images/homePage.jpg");
  }

  Widget homeDescription(BuildContext context) {
    return ClipPath(
      clipper: SkewCut(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        height: 180,
        color: Colors.black,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              text1,
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              text2,
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text3,
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        ),
      ),
    );
  }

  final style = TextStyle(color: Colors.white);

  Widget followPane(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text("Follow", style: Theme.of(context).textTheme.headline3),
          Spacer(),
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.facebookSquare,
              semanticLabel: "Facebook",
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.twitter,
              semanticLabel: "Twitter",
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
