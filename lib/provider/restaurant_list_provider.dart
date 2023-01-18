import 'dart:async';
import 'dart:io';

import 'package:bfaf_submission2/data/model/restaurant_list.dart';
import 'package:bfaf_submission2/utils/result_state.dart';
import 'package:flutter/material.dart';

import '../data/api/api_service.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  ResultState<RestaurantList> _state =
      ResultState(status: StatusState.loading, message: null, data: null);

  ResultState<RestaurantList> get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState(status: StatusState.loading, message: null, data: null);
      notifyListeners();
      final restaurants = await apiService.getRestoList();
      if (restaurants.restaurants.isNotEmpty) {
        _state =
            ResultState(status: StatusState.hasData, message: null, data: restaurants);
        notifyListeners();
        return _state;
      } else {
        _state = ResultState(status: StatusState.noData, message: 'There are no restaurants', data: null);
        notifyListeners();
        return _state;
      }
    } on TimeoutException catch (e) {
      _state = ResultState(status: StatusState.error, message: 'Internet kamu lagi bermasalah coba periksa lagi!', data: null);
      notifyListeners();
      return _state;
    } on SocketException catch (e) {
      _state = ResultState(
          status: StatusState.error, message: 'Internet kamu lagi bermasalah coba periksa lagi!', data: null);
      notifyListeners();
      return _state;
    } catch (e) {
      _state = ResultState(status: StatusState.error, message: '$e Something went wrong', data: null);
      notifyListeners();
      return _state;
    }
  }
}
