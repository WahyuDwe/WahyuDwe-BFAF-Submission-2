import 'dart:convert';
import 'dart:developer';
import 'dart:math';


import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

import '../data/model/restaurant_list.dart';
import 'navigation.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantList restaurants) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "my restaurant channel";
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    var randomRestaurant = Random().nextInt(restaurants.restaurants.length - 1);
    var body = restaurants.restaurants[randomRestaurant].name;
    await flutterLocalNotificationsPlugin.show(
      0,
      '<b>New Restaurant</b>',
      body,
      platformChannelSpecifics,
      payload: json.encode(restaurants.restaurants[0].toJson()),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = RestaurantList.fromJson(json.decode(payload));
        var restaurant = data.restaurants[0];
        Navigation.intentWithData(route, restaurant.id);
      },
    );
  }
}
