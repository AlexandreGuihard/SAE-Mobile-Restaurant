import 'package:flutter/foundation.dart';
import 'package:sae_mobile/model/restaurant.dart';

class RestaurantProvider extends ChangeNotifier{
  final db;
  final supabase;

  RestaurantProvider({required this.db, required this.supabase});

  // Selects
  Future<List<Restaurant>> getRestaurants() async {
    return await db.query('RESTAURANT');
  }

  Future<Restaurant> getRestaurantFromId(int idRestaurant) async {
    return await db.query('RESTAURANT', where: 'idRestaurant = $idRestaurant');
  }

  // Inserts
  void insertRestaurant(Restaurant restaurant) async {
    await db.insert("RESTAURANT", restaurant.toMap());
  }

  // Update
  void updateRestaurant(Restaurant restaurant) async {
    int idRestaurant=restaurant.id;
    await db.update("RESTAURANT", restaurant.toMap(), where: 'idRestaurant = $idRestaurant');
  }

  // Delete
  void deleteRestaurant(int idRestaurant) async {
    await db.delete("RESTAURANT", where: 'idRestaurant = $idRestaurant');
  }
}