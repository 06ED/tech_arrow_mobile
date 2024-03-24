import 'package:flutter_app/app/models/place.dart';
import 'package:flutter_app/app/networking/api_service.dart';
import 'package:nylo_framework/nylo_framework.dart';

class PlacesApiService extends ApiService {
  @override
  String get baseUrl => "${getEnv('API_BASE_URL')}/places";

  Future<List<PlaceModel>?> fetchPlaces() async =>
      await network<List<PlaceModel>>(request: (request) => request.get(""));

  Future<PlaceModel?> fetchById(int id) async =>
      await network(request: (request) => request.post("", data: {"id": id}));
}
