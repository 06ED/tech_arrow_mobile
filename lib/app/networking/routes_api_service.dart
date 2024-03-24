import 'package:flutter_app/app/models/route.dart';
import 'package:flutter_app/app/networking/api_service.dart';
import 'package:nylo_framework/nylo_framework.dart';

class RoutesApiService extends ApiService {
  @override
  String get baseUrl => "${getEnv('API_BASE_URL')}/routes";

  Future<List<RouteModel>?> fetchRoutes() async =>
      await network<List<RouteModel>>(request: (request) => request.get(""));

  Future<RouteModel?> fetchRouteById(int id) async =>
      await network(request: (request) => request.post("", data: {"id": id}));
}
