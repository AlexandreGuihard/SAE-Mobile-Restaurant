import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../model/cuisine.dart';

class CuisineProvider extends ChangeNotifier{
  final db;

  CuisineProvider({required this.db});

  void insertCuisine(Cuisine cuisine) async{
    print(db);
    await db.insert("CUISINE", cuisine.toMap());
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