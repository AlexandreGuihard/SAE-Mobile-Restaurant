import 'package:flutter/foundation.dart';

import '../model/emplacement.dart';

class EmplacementProvider extends ChangeNotifier{
  final db;
  final supabase;

  EmplacementProvider({required this.db, required this.supabase});
  EmplacementProvider.supabaseOnly({required this.supabase}) : db = null;

  void insertEmplacement(Emplacement emplacement) async{
    await db.insert("emplacement", emplacement.toMap());
  }

  Future<Emplacement> getEmplacementFromCommune(String commune) async{
    final Map<String, dynamic> map = await db.query("emplacement", where:"commune=$commune");

    return Emplacement.fromMap(map);
  }

  Future<Emplacement> getEmplacementFromCommuneSupabase(String commune) async{
    final Map<String, dynamic> map=await supabase.from("emplacement").select().eq("commune", commune).single();
    return Emplacement.fromMap(map);
  }

  Future<List<Emplacement>> getEmplacements() async{
    final List<Map<String, dynamic>> maps = await db.query("emplacement");

    return List.generate(maps.length, (i) {
      return Emplacement.fromMap(maps[i]);
    });
  }

  Future<List<Emplacement>> getEmplacementsSupabase() async{
    final List<Map<String, dynamic>> maps=await supabase.from("emplacement").select();
    return List.generate(maps.length, (i){
      return Emplacement.fromMap(maps[i]);
    });
  }

  void deleteEmplacement(String commune) async{
    await db.delete("emplacement", where:"commune=$commune");
  }

  void updateEmplacement(Emplacement emplacement) async{
    String commune=emplacement.commune;
    await db.update("emplacement", emplacement.toMap(), where:"commune=$commune");
  }
}