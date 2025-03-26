import 'package:flutter/foundation.dart';
import 'package:sae_mobile/model/typerestaurant.dart';

class TypeRestaurantProvider extends ChangeNotifier{
  final db;
  final supabase;

  TypeRestaurantProvider({required this.db, required this.supabase});

  // Selects
  Future<List<TypeRestaurant>> getTypesRestaurants() async {
    return await db.query('TYPERESTAURANT');
  }

  Future<TypeRestaurant> getTypeRestaurantsFromId(int idType) async {
    return await db.query('TYPERESTAURANT', where: 'idType = $idType');
  }

  // Inserts
  void insertTypeRestaurants(TypeRestaurant type) async {
    await db.insert("TYPERESTAURANT", type.toMap());
  }

  // Update
  void updateTypeRestaurants(TypeRestaurant type) async {
    int idType=type.id;
    await db.update("TYPERESTAURANT", type.toMap(), where: 'idType = $idType');
  }

  // Delete
  void deleteTypeRestaurants(int idType) async {
    await db.delete("TYPERESTAURANT", where: 'idType =$idType');
  }
}