import 'package:flutter_app/app/controllers/favorite_controller.dart';
import 'package:flutter_app/app/controllers/user_controller.dart';
import 'package:flutter_app/app/models/place.dart';
import 'package:flutter_app/app/models/route.dart';
import 'package:flutter_app/app/networking/places_api_service.dart';
import 'package:flutter_app/app/networking/routes_api_service.dart';
import 'package:flutter_app/app/networking/user_api_service.dart';

import '/app/controllers/home_controller.dart';
import '/app/models/user.dart';
import '/app/networking/api_service.dart';

/* Model Decoders
|--------------------------------------------------------------------------
| Model decoders are used in 'app/networking/' for morphing json payloads
| into Models.
|
| Learn more https://nylo.dev/docs/5.20.0/decoders#model-decoders
|-------------------------------------------------------------------------- */

final Map<Type, dynamic> modelDecoders = {
  User: (data) => User.fromJson(data),
  PlaceModel: (data) => PlaceModel.fromJson(data),
  RouteModel: (data) => RouteModel.fromJson(data),

  List<PlaceModel>: (data) => List.from(data).map((json) => PlaceModel.fromJson(json)).toList(),
  List<RouteModel>: (data) => List.from(data).map((json) => RouteModel.fromJson(json)).toList(),
};

/* API Decoders
| -------------------------------------------------------------------------
| API decoders are used when you need to access an API service using the
| 'api' helper. E.g. api<MyApiService>((request) => request.fetchData());
|
| Learn more https://nylo.dev/docs/5.20.0/decoders#api-decoders
|-------------------------------------------------------------------------- */

final Map<Type, dynamic> apiDecoders = {
  ApiService: () => ApiService(),
  PlacesApiService: () => PlacesApiService(),
  RoutesApiService: () => RoutesApiService(),
  UserApiService: () => UserApiService(),
};


/* Controller Decoders
| -------------------------------------------------------------------------
| Controller are used in pages.
|
| Learn more https://nylo.dev/docs/5.20.0/controllers
|-------------------------------------------------------------------------- */
final Map<Type, dynamic> controllers = {
  HomeController: () => HomeController(),
  UserController: () => UserController(),
  FavoriteController: () => FavoriteController(),
};

