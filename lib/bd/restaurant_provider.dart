import 'package:flutter/foundation.dart';
import 'package:sae_mobile/model/restaurant.dart';

class RestaurantProvider extends ChangeNotifier {
  final db;
  final supabase;

  RestaurantProvider({required this.db, required this.supabase});
  RestaurantProvider.supabaseOnly({required this.supabase}) : db = null;

  Future<List<Restaurant>> getRestaurantsSupabase() async {
    final List<dynamic> data = await supabase.from("restaurant").select();

    return data.map<Restaurant>((item) {
      final map = item as Map<String, dynamic>;
      return Restaurant.fromMap(map);
    }).toList();
  }

  Future<Restaurant?> getRestaurantFromIdSupabase(int idRestaurant) async {
    print("get favoris");
    final List<dynamic> data = await supabase
        .from("restaurant")
        .select()
        .eq("idrestaurant", idRestaurant);

    if (data.isNotEmpty) {
      final map = data.first as Map<String, dynamic>;
      return Restaurant.fromMap(map);
    } else {
      return null;
    }
  }

  Future<List<Restaurant?>> getFavorisRestaurant(int idUtilisateur) async {
    final List<Map<String, dynamic>> maps = await db.query(
      'prefererrestaurant',
      where: "idutilisateur= ?",
      whereArgs: [idUtilisateur],
    );

    return Future.wait(
      maps.map((map) async {
        return await getRestaurantFromIdSupabase(map["idrestaurant"]);
      }),
    );
  }

  Future<void> insertRestaurantSupabase(Restaurant restaurant) async {
    await supabase.from("restaurant").insert(restaurant.toMap());
  }

  Future<void> ajouterFavorisRestaurant(int idUtilisateur, int idRestaurant) async {
    await db.insert(
      "prefererrestaurant",
      {"idutilisateur": idUtilisateur, "idrestaurant": idRestaurant},
    );
  }

  Future<void> updateRestaurantSupabase(Restaurant restaurant) async {
    await supabase
        .from("restaurant")
        .update(restaurant.toMap())
        .eq("idrestaurant", restaurant.id);
  }

  Future<void> deleteRestaurantSupabase(int idRestaurant) async {
    await supabase
        .from("restaurant")
        .delete()
        .eq("idrestaurant", idRestaurant);
  }

  Future<void> supprimerFavorisRestaurant(int idUtilisateur, int idRestaurant) async {
    print(idUtilisateur);
    print(idRestaurant);
    await db.delete(
      "prefererrestaurant",
      where: "idutilisateur= ? and idrestaurant= ?",
      whereArgs: [idUtilisateur, idRestaurant],
    );
  }
}
