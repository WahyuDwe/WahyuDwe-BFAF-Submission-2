import 'package:bfaf_submission2/data/model/restaurant_list.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal(){
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblRestaurant = 'restaurants';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurant.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblRestaurant (
             id TEXT PRIMARY KEY,
             name TEXT,
             description TEXT,
             pictureId TEXT,
             city TEXT,
             rating DOUBLE
           )     
        ''');
      },
      version: 2,
    );

    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();

    return _database;
  }

  Future<void> insertRestaurant(RestaurantListElement restaurants) async {
    final db = await database;
    await db!.insert(_tblRestaurant, restaurants.toJson());
  }

  Future<List<RestaurantListElement>> getRestaurants() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblRestaurant);

    return results.map((res) => RestaurantListElement.fromJson(res)).toList();
  }

  Future<Map> getRestaurantById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tblRestaurant,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> deleteRestaurant(String id) async {
    final db = await database;
    await db!.delete(_tblRestaurant, where: 'id = ?', whereArgs: [id]);
  }
}