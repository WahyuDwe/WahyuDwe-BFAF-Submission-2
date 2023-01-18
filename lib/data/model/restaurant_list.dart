import 'package:bfaf_submission2/data/model/restaurant_detail.dart';

class RestaurantList {
  RestaurantList({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  bool error;
  String message;
  int count;
  List<RestaurantListElement> restaurants;

  factory RestaurantList.fromJson(Map<String, dynamic> json) =>
      RestaurantList(
          error: json["error"],
          message: json["message"],
          count: json["count"],
          restaurants: (json["restaurants"] as List)
              .map((x) => RestaurantListElement.fromJson(x))
              .toList());
}

class RestaurantListElement {
  RestaurantListElement({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    this.menus,
  });

  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus? menus;

  factory RestaurantListElement.fromJson(Map<String, dynamic> json) =>
      RestaurantListElement(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
        menus: json['menus'] != null
            ? Menus.fromJson(json["menus"])
            : Menus(foods: [], drinks: []),
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
