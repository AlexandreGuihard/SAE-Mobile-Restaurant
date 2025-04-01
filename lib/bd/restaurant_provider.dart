import 'package:flutter/foundation.dart';
import 'package:sae_mobile/model/restaurant.dart';

class RestaurantProvider extends ChangeNotifier{
  final db;
  final supabase;

  RestaurantProvider({required this.db, required this.supabase});

  // Selects
  Future<List<Restaurant>> getRestaurants() async {
    final List<Map<String, dynamic>> maps = await db.query('restaurant');

    return List.generate(maps.length, (i) {
      return Restaurant.fromMap(maps[i]);
    });
  }

  Future<Restaurant> getRestaurantFromId(int idRestaurant) async {
    final Map<String, dynamic> map = await db.query('restaurant', where: 'idrestaurant = $idRestaurant');

    return Restaurant.fromMap(map);
  }

  // Inserts
  void insertRestaurant(Restaurant restaurant) async {
    await db.insert("restaurant", restaurant.toMap());
  }

  // Update
  void updateRestaurant(Restaurant restaurant) async {
    int idRestaurant=restaurant.id;
    await db.update("restaurant", restaurant.toMap(), where: 'idrestaurant = $idRestaurant');
  }

  // Delete
  void deleteRestaurant(int idRestaurant) async {
    await db.delete("restaurant", where: 'idrestaurant = $idRestaurant');
  }

  Future<List<Restaurant>> getRestaurantsSupabase() async{
    final List<Map<String, dynamic>> maps=await supabase.from("restaurant").select();
    return List.generate(maps.length, (i){
      return Restaurant.fromMap(maps[i]);
    });
  }
}