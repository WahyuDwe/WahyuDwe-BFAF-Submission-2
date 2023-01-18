import 'package:bfaf_submission2/data/api/api_service.dart';
import 'package:bfaf_submission2/provider/restaurant_detail_provider.dart';
import 'package:bfaf_submission2/provider/restaurant_list_provider.dart';
import 'package:bfaf_submission2/provider/restaurant_search_provider.dart';
import 'package:bfaf_submission2/ui/home_page.dart';
import 'package:bfaf_submission2/ui/restaurant_detail_page.dart';
import 'package:bfaf_submission2/ui/restaurant_search_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
          RestaurantSearchPage.routeName: (context) => const RestaurantSearchPage(),
        },
      ),
    );
  }
}
