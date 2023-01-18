import 'dart:async';
import 'dart:io';

import 'package:bfaf_submission2/data/api/api_service.dart';
import 'package:bfaf_submission2/data/model/restaurant_search_list.dart';
import 'package:bfaf_submission2/utils/result_state.dart';
import 'package:flutter/cupertino.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService}) {
    fetchRestaurantSearch(query);
  }

  ResultState<RestaurantSearchList> _state = ResultState(
      status: StatusState.hasData,
      message: null,
      data: RestaurantSearchList(
        error: false,
        founded: 0,
        restaurants: [],
      ));

  String _query = '';

  ResultState<RestaurantSearchList> get state => _state;

  String get query => _query;

  Future<dynamic> fetchRestaurantSearch(String query) async {
    try {
      _state =
          ResultState(status: StatusState.loading, message: null, data: null);
      _query = query;
      notifyListeners();
      if (_query != '') {
        final restaurant = await apiService.getRestoSearch(query);
        if (restaurant.restaurants.isEmpty) {
          _state = ResultState(
              status: StatusState.noData, message: 'Empty Data', data: null);
          notifyListeners();
          return _state;
        } else {
          _state = ResultState(
              status: StatusState.hasData, message: null, data: restaurant);
          notifyListeners();
          return _state;
        }
      } else {
        _state = ResultState(
            status: StatusState.textFieldEmpty,
            message: 'Find ur favorite restaurant',
            data: null);
        notifyListeners();
        return _state;
      }
    } on TimeoutException catch (e) {
      _state = ResultState(
          status: StatusState.error,
          message: 'Internet kamu lagi bermasalah coba periksa lagi!',
          data: null);
      notifyListeners();
      return _state;
    } on SocketException catch (e) {
      _state = ResultState(
          status: StatusState.error,
          message: 'Internet kamu lagi bermasalah coba periksa lagi!',
          data: null);
      notifyListeners();
      return _state;
    } catch (e) {
      _state = ResultState(
          status: StatusState.error, message: 'Error --> $e', data: null);
      notifyListeners();
      return _state;
    }
  }
}
