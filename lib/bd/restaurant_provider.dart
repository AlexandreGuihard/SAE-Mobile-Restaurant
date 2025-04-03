import 'package:flutter/foundation.dart';
import 'package:sae_mobile/model/restaurant.dart';

class RestaurantProvider extends ChangeNotifier{
  final db;
  final supabase;

  RestaurantProvider({required this.db, required this.supabase});
  RestaurantProvider.supabaseOnly({required this.supabase}) : db = null;

  // Selects
  Future<List<Restaurant>> getRestaurantsSupabase() async{
    final List<Map<String, dynamic>> maps=await supabase.from("restaurant").select();
    return List.generate(maps.length, (i){
      return Restaurant.fromMap(maps[i]);
    });
  }

  Future<Restaurant?> getRestaurantFromIdSupabase(int idRestaurant) async{
    print("get favoris");
    final List<Map<String, dynamic>> map=await supabase.from("restaurant").select().eq("idrestaurant", idRestaurant);

    if (map.isNotEmpty) {
      return Restaurant.fromMap(map.first);
    } else {
      return null;
    }
  }

  // favoris
  Future<List<Restaurant?>> getFavorisRestaurant(int idUtilisateur) async {
    final List<Map<String, dynamic>> maps = await db.query('prefererrestaurant', where: "idutilisateur= ?", whereArgs: [idUtilisateur]);
    return Future.wait(maps.map((map) async {
      return await getRestaurantFromIdSupabase(map["idrestaurant"]);
    }));
  }

  Future<Restaurant> getRestaurantFromIdSupabase(int idRestaurant) async{
    final Map<String, dynamic> map= await supabase.from("restaurant").select().eq("idrestaurant", idRestaurant).single();
    return Restaurant.fromMap(map);
  }

  // Inserts
  void insertRestaurant(Restaurant restaurant) async {
    await db.insert("restaurant", restaurant.toMap());
  }

  void ajouterFavorisRestaurant(int idUtilisateur, int idRestaurant) async {
    await db.insert(
        "prefererrestaurant",
        {"idutilisateur": idUtilisateur, "idrestaurant": idRestaurant});
  }

  // Update


  // Delete
  void supprimerFavorisRestaurant(int idUtilisateur, int idRestaurant) async {
    print(idUtilisateur);
    print(idRestaurant);
    await db.delete(
      "prefererrestaurant",
      where: "idutilisateur= ? and idrestaurant= ?",
      whereArgs: [idUtilisateur, idRestaurant]
    );
  }
}