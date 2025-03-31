import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../model/cuisine.dart';

class CuisineProvider extends ChangeNotifier{
  final db;
  final supabase;

  CuisineProvider({required this.db, required this.supabase});

  void insertCuisine(Cuisine cuisine) async{
    print(db);
    await db.insert("CUISINE", cuisine.toMap());
  }

  Future<Cuisine> getCuisineFromId(int idCuisine) async{
    final Map<String, dynamic> map = await db.query("CUISINE", where:"idCuisine=$idCuisine");

    return Cuisine.fromMap(map);
  }

  Future<List<Cuisine>> getCuisines() async{
    final List<Map<String, dynamic>> maps = await db.query("CUISINE");

    return List.generate(maps.length, (i) {
      return Cuisine.fromMap(maps[i]);
    });
  }

  void deleteCuisine(int idCuisine) async{
    await db.delete("CUISINE", where:"idCuisine=$idCuisine");
  }

  void updateCuisine(Cuisine cuisine) async{
    int idCuisine=cuisine.id;
    await db.update("CUISINE", cuisine.toMap(), where:"idCuisine=$idCuisine");
  }
}