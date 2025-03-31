import 'package:flutter/foundation.dart';
import 'package:sae_mobile/model/typerestaurant.dart';

class TypeRestaurantProvider extends ChangeNotifier{
  final db;

  TypeRestaurantProvider({required this.db});

  // Selects
  Future<List<TypeRestaurant>> getTypesRestaurants() async {
    final List<Map<String, dynamic>> maps = await db.query('TYPERESTAURANT');

    return List.generate(maps.length, (i) {
      return TypeRestaurant.fromMap(maps[i]);
    });
  }

  Future<TypeRestaurant> getTypeRestaurantsFromId(int idType) async {
    final Map<String, dynamic> map = await db.query('TYPERESTAURANT', where: 'idType = $idType');

    return TypeRestaurant.fromMap(map);
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