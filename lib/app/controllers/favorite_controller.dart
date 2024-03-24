import 'package:flutter_app/app/controllers/controller.dart';
import 'package:flutter_app/app/models/place.dart';
import 'package:flutter_app/app/models/route.dart';
import 'package:flutter_app/app/networking/places_api_service.dart';
import 'package:flutter_app/app/networking/routes_api_service.dart';
import 'package:flutter_app/config/storage_keys.dart';
import 'package:nylo_framework/nylo_framework.dart';

class FavoriteController extends Controller {
  Future<List<RouteModel>> getFavoritePosts() async {
    final postsIds = await NyStorage.readCollection(StorageKey.favoritePosts);
    final posts = <RouteModel>[];

    postsIds.forEach((id) async => posts.add(
          await api<RoutesApiService>((request) => request.fetchRouteById(id)),
        ));
    return posts;
  }

  Future<List<PlaceModel>> getFavoritePlaces() async {
    final placesIds = await NyStorage.readCollection(StorageKey.favoritePlaces);
    final places = <PlaceModel>[];

    placesIds.forEach((id) async => places
        .add(await api<PlacesApiService>((request) => request.fetchById(id))));

    return places;
  }
}
