import 'package:flutter/material.dart';
import 'package:flutter_app/resources/widgets/route_card.dart';

import '../../../../../app/models/route.dart';

class FavoritePostsTab extends StatelessWidget {
  final List<RouteModel> routes;

  const FavoritePostsTab({super.key, required this.routes});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.all(10),
          child: RouteCard(
            rating: routes[index].rating!,
            title: routes[index].title!,
            description: routes[index].description!,
            time: routes[index].duration!,
          ),
        ),
        itemCount: routes.length,
      ),
    );
  }
}
