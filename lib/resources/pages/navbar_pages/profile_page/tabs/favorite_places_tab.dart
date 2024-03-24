import 'package:flutter/material.dart';
import 'package:flutter_app/resources/widgets/place_card.dart';

import '../../../../../app/models/place.dart';

class FavoritePlacesTab extends StatelessWidget {
  final List<PlaceModel> places;

  const FavoritePlacesTab({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.all(10),
          child: PlaceCard(
            rating: places[index].rating!,
            title: places[index].title!,
            image: places[index].image,
          ),
        ),
        itemCount: places.length,
      ),
    );
  }
}
