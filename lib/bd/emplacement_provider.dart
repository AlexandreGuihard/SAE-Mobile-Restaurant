import 'package:flutter/foundation.dart';

import '../model/emplacement.dart';

class EmplacementProvider extends ChangeNotifier{
  final db;
  final supabase;

  EmplacementProvider({required this.db, required this.supabase});

  void insertEmplacement(Emplacement emplacement) async{
    await db.insert("EMPLACEMENT", emplacement.toMap());
  }

  Future<Emplacement> getEmplacementFromCommune(String commune) async{
    return await db.query("EMPLACEMENT", where:"commune=$commune");
  }

  Future<List<Emplacement>> getEmplacements() async{
    return await db.query("EMPLACEMENT");
  }

  void deleteEmplacement(String commune) async{
    await db.delete("EMPLACEMENT", where:"commune=$commune");
  }

  void updateEmplacement(Emplacement emplacement) async{
    String commune=emplacement.commune;
    await db.update("EMPLACEMENT", emplacement.toMap(), where:"commune=$commune");
  }
}