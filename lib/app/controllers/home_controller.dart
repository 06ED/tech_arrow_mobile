import 'package:flutter_app/app/models/route.dart';
import 'package:flutter_app/app/networking/places_api_service.dart';
import 'package:flutter_app/app/networking/routes_api_service.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '../models/place.dart';
import 'controller.dart';

class HomeController extends Controller {
  Future<List<PlaceModel>?> getPlaces() async =>
      await api<PlacesApiService>((request) => request.fetchPlaces());

  Future<List<RouteModel>?> getRoutes() async =>
      await api<RoutesApiService>((request) => request.fetchRoutes());
}
