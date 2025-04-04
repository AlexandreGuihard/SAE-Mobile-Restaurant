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

  void insertRestaurantSupabase(Restaurant restaurant) async {
    await supabase.from("restaurant").insert(restaurant.toMap());
  }

  void updateRestaurantSupabase(Restaurant restaurant) async {
    await supabase.from("restaurant").update(restaurant.toMap()).eq("idrestaurant", restaurant.id);
  }

  void deleteRestaurantSupabase(int idRestaurant) async {
    await supabase.from("restaurant").delete().eq("idrestaurant", idRestaurant);
  }

  Future<List<Restaurant>> getRestaurantsSupabase() async{
    final List<Map<String, dynamic>> maps=await supabase.from("restaurant").select();
    return List.generate(maps.length, (i){
      return Restaurant.fromMap(maps[i]);
    });
  }

  Future<Restaurant?> getRestaurantFromIdSupabase(int idRestaurant) async{
    final List<Map<String, dynamic>> map=await supabase.from("restaurant").select().eq("restaurant", idRestaurant);

    if (map.isNotEmpty) {
      return Restaurant.fromMap(map.first);
    } else {
      return null;
    }
  }
}