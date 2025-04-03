import 'package:flutter/foundation.dart';
import 'package:sae_mobile/model/typerestaurant.dart';

class TypeRestaurantProvider extends ChangeNotifier{
  final db;
  final supabase;

  TypeRestaurantProvider({required this.db, required this.supabase});
  TypeRestaurantProvider.supabaseOnly({required this.supabase}) : db = null;

  // Selects
  Future<List<TypeRestaurant>> getTypesRestaurants() async {
    final List<Map<String, dynamic>> maps = await db.query('typerestaurant');

    return List.generate(maps.length, (i) {
      return TypeRestaurant.fromMap(maps[i]);
    });
  }

  Future<List<TypeRestaurant>> getTypesRestaurantsSupabase() async{
    final List<Map<String, dynamic>> maps=await supabase.from("typerestaurant").select();
    return List.generate(maps.length, (i){
      return TypeRestaurant.fromMap(maps[i]);
    });
  }

  Future<TypeRestaurant> getTypeRestaurantsFromId(int idType) async {
    final Map<String, dynamic> map = await db.query('typerestaurant', where: 'idtype = $idType');

    return TypeRestaurant.fromMap(map);
  }

  Future<TypeRestaurant> getTypeRestaurantFromIdSupabase(int idType) async{
    final Map<String, dynamic> map=await supabase.from("typerestaurant").select().eq("idtype", idType).single();
    return TypeRestaurant.fromMap(map);
  }

  // Inserts
  void insertTypeRestaurants(TypeRestaurant type) async {
    await db.insert("typerestaurant", type.toMap());
  }

  // Update
  void updateTypeRestaurants(TypeRestaurant type) async {
    int idType=type.id;
    await db.update("typerestaurant", type.toMap(), where: 'idtype = $idType');
  }

  // Delete
  void deleteTypeRestaurants(int idType) async {
    await db.delete("typerestaurant", where: 'idtype =$idType');
  }
}