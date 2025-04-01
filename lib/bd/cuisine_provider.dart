import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../model/cuisine.dart';

class CuisineProvider extends ChangeNotifier{
  final db;
  final supabase;

  CuisineProvider({required this.db, required this.supabase});

  void insertCuisine(Cuisine cuisine) async{
    await db.insert("CUISINE", cuisine.toMap());
  }

  Future<Cuisine> getCuisineFromId(int idCuisine) async{
    final Map<String, dynamic> map = await db.query("cuisine", where:"idCuisine=$idCuisine");
    return Cuisine.fromMap(map);
  }

  Future<Cuisine> getCuisineFromIdSupabase(int idCuisine) async{
    return await supabase.from("cuisine").select().eq("idcuisine", idCuisine);
  }

  Future<List<Cuisine>> getCuisines() async{
    final List<Map<String, dynamic>> maps = await db.query("cuisine");

    return List.generate(maps.length, (i) {
      return Cuisine.fromMap(maps[i]);
    });
  }

  Future<List<Cuisine>> getCuisinesSupabase() async{
    final List<Map<String, dynamic>> maps=await supabase.from("cuisine").select();
    return List.generate(maps.length, (i){
      return Cuisine.fromMap(maps[i]);
    });
  }

  void deleteCuisine(int idCuisine) async{
    await db.delete("cuisine", where:"idcuisine=$idCuisine");
  }

  void updateCuisine(Cuisine cuisine) async{
    int idCuisine=cuisine.id;
    await db.update("cuisine", cuisine.toMap(), where:"idcuisine=$idCuisine");
  }
}