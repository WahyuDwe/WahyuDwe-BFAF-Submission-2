import 'package:bfaf_submission2/data/model/restaurant_list.dart';
import 'package:flutter/material.dart';

import '../data/db/db_helper.dart';
import '../utils/result_state.dart';

class RestaurantDatabaseProvider extends ChangeNotifier {
  final DatabaseHelper dbHelper;

  RestaurantDatabaseProvider({required this.dbHelper}) {
    getFavorite();
  }

  StatusState? _state;

  StatusState? get state => _state;

  String _message = '';

  String get message => _message;

  List<RestaurantListElement> _favorite = [];

  List<RestaurantListElement> get favorite => _favorite;

  void getFavorite() async {
    _favorite = await dbHelper.getRestaurants();
    if (_favorite.isNotEmpty) {
      _state = StatusState.hasData;
    } else {
      _state = StatusState.noData;
      _message = 'Kamu belum punya resto favorit';
    }
    notifyListeners();
  }

  void addFavorite(RestaurantListElement restaurant) async {
    try {
      await dbHelper.insertRestaurant(restaurant);
      getFavorite();
    } catch (e) {
      _state = StatusState.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteRestaurant = await dbHelper.getRestaurantById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await dbHelper.deleteRestaurant(id);
      getFavorite();
    } catch (e) {
      _state = StatusState.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }
}
