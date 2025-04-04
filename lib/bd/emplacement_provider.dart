import 'package:flutter/foundation.dart';

import '../model/emplacement.dart';

class EmplacementProvider extends ChangeNotifier{
  final db;
  final supabase;

  EmplacementProvider({required this.db, required this.supabase});

  void insertEmplacementSupabase(Emplacement emplacement) async{
    await supabase.from("emplacement").insert(emplacement.toMap());
  }

  Future<Emplacement> getEmplacementFromCommune(String commune) async{
    final Map<String, dynamic> map = await db.query("emplacement", where:"commune=$commune");

    return Emplacement.fromMap(map);
  }

  Future<Emplacement> getEmplacementFromCommuneSupabase(String commune) async{
    final Map<String, dynamic> map=await supabase.from("emplacement").select().eq("commune", commune);
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

  void deleteEmplacementSupabase(String commune) async{
    await supabase.from("emplacement").delete().eq("commune", commune);
  }

  void updateEmplacementSupabase(Emplacement emplacement) async{
    await supabase.from("emplacement").update(emplacement.toMap()).eq("commune", emplacement.commune);
  }
}