
import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:bfaf_submission2/data/api/api_service.dart';
import 'package:bfaf_submission2/provider/preference_provider.dart';
import 'package:bfaf_submission2/provider/restaurant_db_provider.dart';
import 'package:bfaf_submission2/provider/restaurant_detail_provider.dart';
import 'package:bfaf_submission2/provider/restaurant_list_provider.dart';
import 'package:bfaf_submission2/provider/restaurant_search_provider.dart';
import 'package:bfaf_submission2/provider/scheduling_provider.dart';
import 'package:bfaf_submission2/ui/favorite_page.dart';
import 'package:bfaf_submission2/ui/home_page.dart';
import 'package:bfaf_submission2/ui/restaurant_detail_page.dart';
import 'package:bfaf_submission2/ui/restaurant_search_page.dart';
import 'package:bfaf_submission2/ui/setting_page.dart';
import 'package:bfaf_submission2/utils/background_service.dart';
import 'package:bfaf_submission2/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/db/db_helper.dart';
import 'data/preferences/preferences_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantListProvider>(
          create: (_) => RestaurantListProvider(apiService: apiService),
        ),
        ChangeNotifierProvider<RestaurantDetailProvider>(
          create: (_) => RestaurantDetailProvider(apiService: apiService),
        ),
        ChangeNotifierProvider<RestaurantSearchProvider>(
          create: (_) => RestaurantSearchProvider(apiService: apiService),
        ),
        ChangeNotifierProvider<RestaurantDatabaseProvider>(
          create: (_) => RestaurantDatabaseProvider(dbHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider<PreferencesProvider>(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider())
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                restoId: ModalRoute.of(context)?.settings.arguments as String,
              ),
          RestaurantSearchPage.routeName: (context) =>
              const RestaurantSearchPage(),
          RestaurantFavoritePage.routeName: (context) =>
              const RestaurantFavoritePage(),
          SettingsPage.routeName: (context) => const SettingsPage(),
        },
      ),
    );
  }
}
