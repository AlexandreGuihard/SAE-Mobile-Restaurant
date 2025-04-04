import 'package:flutter/foundation.dart';
import 'package:sae_mobile/model/typerestaurant.dart';

class TypeRestaurantProvider extends ChangeNotifier{
  final db;
  final supabase;

  TypeRestaurantProvider({required this.db, required this.supabase});

  // Selects
  Future<List<TypeRestaurant>> getTypesRestaurants() async {
    final List<Map<String, dynamic>> maps = await db.query('typerestaurant');

    return List.generate(maps.length, (i) {
      return TypeRestaurant.fromMap(maps[i]);
    });
  }

  Future<TypeRestaurant> getTypeRestaurantsFromId(int idType) async {
    final Map<String, dynamic> map = await db.query('typerestaurant', where: 'idtype = $idType');

    return TypeRestaurant.fromMap(map);
  }

  void insertTypeRestaurantsSupabase(TypeRestaurant type) async {
    await supabase.from("typerestaurant").insert(type.toMap());
  }

  void updateTypeRestaurantsSupabase(TypeRestaurant type) async {
    await supabase.from("typerestaurant").update(type.toMap()).eq("idtype", type.id);
  }

  void deleteTypeRestaurantsSupabase(int idType) async {
    await supabase.from("typerestaurant").delete().eq("idtype", idType);
  }
}