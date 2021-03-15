import 'package:flutter/material.dart';
import 'package:marvel_comics/view/widgets/skewCut_widget.dart';

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

  Widget homeImage() {
    return Image.network(homeImageUrl);
    // return FadeInImage.memoryNetwork(
    //   placeholder: kTransparentImage,
    //   image: homeImageUrl,
    // );
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

  final style = TextStyle(color: Colors.white);

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
}
