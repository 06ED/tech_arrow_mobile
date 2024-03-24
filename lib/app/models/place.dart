import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class PlaceModel extends Model {
  int? id;
  int? category;
  String? title;
  double? lat;
  double? lon;
  double? rating;
  String? description;
  String? imagePath;

  PlaceModel({
    this.id,
    this.title,
    this.lat,
    this.lon,
    this.rating,
    this.description,
    this.imagePath,
    this.category,
  });

  PlaceModel.fromJson(dynamic data)
      : id = data["id"],
        title = data["title"],
        lat = data["lat"],
        lon = data["long"],
        rating = data["rating"],
        imagePath = data["image"],
        category = data["category"],
        description = data["description"];

  Image get image => Image.network(
        "${getEnv("SERVER_URL")}/uploads/$imagePath",
        fit: BoxFit.fitWidth,
        width: double.infinity,
      );

  @override
  toJson() => {
        "id": id,
        "title": title,
        "lat": lat,
        "lon": lon,
        "rating": rating,
        "category": category,
        "description": description,
      };
}
