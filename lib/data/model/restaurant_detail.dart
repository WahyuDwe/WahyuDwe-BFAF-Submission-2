
import 'dart:convert';

import 'package:bfaf_submission2/data/model/restaurant_list.dart';

RestaurantDetail? restaurantFromJson(String str) => RestaurantDetail.fromJson(json.decode(str));

String restaurantToJson(RestaurantDetail? data) => json.encode(data!.toJson());

class RestaurantDetail {
  RestaurantDetail({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  bool error;
  String message;
  RestaurantListElement restaurant;

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) => RestaurantDetail(
    error: json["error"],
    message: json["message"],
    restaurant: RestaurantListElement.fromJson(json["restaurant"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "restaurant": restaurant,
  };
}

class Category {
  Category({
    required this.name,
  });

  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name: json["name"],
  );
}

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  List<Category> foods;
  List<Category> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) {
    final List<Category> foods = (json["foods"] as List)
        .map((x) => Category.fromJson(x))
        .toList();

    final List<Category> drinks = (json["drinks"] as List)
        .map((x) => Category.fromJson(x))
        .toList();

    return Menus(
      foods: foods,
      drinks: drinks,
    );
  }
}