import 'package:sqflite/sqflite.dart';

import '../model/cuisine.dart';

class CuisineProvider{
  final db;

  const CuisineProvider(this.db);

  void insertCuisine(Cuisine cuisine) async{
    await db.insert("CUISINE", cuisine.toMap(), ConflictAlgorithm.replace);
  }

  Future<Cuisine> getCuisineFromId(int idCuisine) async{
    return await db.query("CUISINE", where:"idCuisine=$idCuisine");
  }

  Future<List<Cuisine>> getCuisines() async{
    return await db.query("CUISINE");
  }

  void deleteCuisine(int idCuisine) async{
    await db.delete("CUISINE", where:"idCuisine=$idCuisine");
  }

  void updateCuisine(Cuisine cuisine) async{
    int idCuisine=cuisine.id;
    await db.update("CUISINE", cuisine.toMap(), where:"idCuisine=$idCuisine");
  }
}