import 'dart:convert';

import 'package:bfaf_submission2/data/model/restaurant_search_list.dart';
import 'package:http/http.dart' as http;

import '../model/restaurant_detail.dart';
import '../model/restaurant_list.dart';

class ApiService{
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  // get list restaurant
  Future<RestaurantList> getRestoList() async {
    final response = await http.get(Uri.parse('${_baseUrl}list'));
    if(response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  // get detail restaurant
  Future<RestaurantDetail> getRestoDetail(String id) async {
    final response = await http.get(Uri.parse('${_baseUrl}detail/$id'));
    if(response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  // get search restaurant
  Future<RestaurantSearchList> getRestoSearch(String query) async {
    final response = await http.get(Uri.parse('${_baseUrl}search?q=$query'));
    if(response.statusCode == 200) {
      return RestaurantSearchList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant search');
    }
  }

}