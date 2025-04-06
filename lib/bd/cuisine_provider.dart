import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../model/cuisine.dart';

class CuisineProvider extends ChangeNotifier{
  final db;
  final supabase;

  CuisineProvider({required this.db, required this.supabase});
  CuisineProvider.supabaseOnly({required this.supabase}) : db = null;

  void insertCuisineSupabase(Cuisine cuisine) async{
    await supabase.from("cuisine").insert(cuisine.toMap());
  }

  Future<Cuisine> getCuisineFromId(int idCuisine) async{
    final Map<String, dynamic> map = await db.query("cuisine", where:"idCuisine=$idCuisine");
    return Cuisine.fromMap(map);
  }

  Future<Cuisine> getCuisineFromIdSupabase(int idCuisine) async{
    final Map<String, dynamic> map=await supabase.from("cuisine").select().eq("idcuisine", idCuisine).single();
    return Cuisine.fromMap(map);
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

  Future<List<Cuisine>> getFavorisCuisine(int idUtilisateur) async {
    final List<Map<String, dynamic>> maps = await db.query('preferercuisine', where: "idutilisateur= ?", whereArgs: [idUtilisateur]);
    return Future.wait(maps.map((map) async {
      return await getCuisineFromIdSupabase(map["idcuisine"]);
    }));
  }

  void deleteCuisineSupabase(int idCuisine) async{
    await supabase.from("cuisine").delete().eq("idcuisine", idCuisine);
  }

  void updateCuisineSupabase(Cuisine cuisine) async{
    await supabase.from("cuisine").update(cuisine.toMap()).eq("idcuisine", cuisine.id);
  }

  void ajouterFavorisCuisine(int idUtilisateur, int idCuisine) async {
    await db.insert(
        "preferercuisine",
        {"idutilisateur": idUtilisateur, "idcuisine": idCuisine});
  }

  void supprimerFavorisCuisine(int idUtilisateur, int idCuisine) async {
    await db.delete("preferercuisine",
        where: "idutilisateur=$idUtilisateur and idcuisine=$idCuisine");
  }
}