import 'package:nylo_framework/nylo_framework.dart';

class RouteModel extends Model {
  int? id;
  String? title;
  String? description;
  double? rating;
  int? duration;
  int? category;

  RouteModel({
    this.id,
    this.title,
    this.description,
    this.rating,
    this.duration,
    this.category,
  });

  RouteModel.fromJson(dynamic data)
      : id = data["id"],
        title = data["title"],
        description = data["description"],
        duration = data["duration"],
        category = data["category"],
        rating = data["rating"];

  @override
  toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "rating": rating,
        "category": category,
      };
}
