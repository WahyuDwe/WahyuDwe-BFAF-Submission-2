import 'package:bfaf_submission2/data/model/restaurant_list.dart';

class RestaurantSearchList {
  RestaurantSearchList({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<RestaurantListElement> restaurants;

  factory RestaurantSearchList.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchList(
        error: json["error"],
        founded: json["founded"],
        restaurants: (json["restaurants"] as List)
            .map((x) => RestaurantListElement.fromJson(x))
            .toList(),
      );
}
