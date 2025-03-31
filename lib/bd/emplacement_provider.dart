import 'package:flutter/foundation.dart';

import '../model/emplacement.dart';

class EmplacementProvider extends ChangeNotifier{
  final db;

  EmplacementProvider({required this.db});

  void insertEmplacement(Emplacement emplacement) async{
    await db.insert("EMPLACEMENT", emplacement.toMap());
  }

  Future<Emplacement> getEmplacementFromCommune(String commune) async{
    final Map<String, dynamic> map = await db.query("EMPLACEMENT", where:"commune=$commune");

    return Emplacement.fromMap(map);
  }

  Future<List<Emplacement>> getEmplacements() async{
    final List<Map<String, dynamic>> maps = await db.query("EMPLACEMENT");

    return List.generate(maps.length, (i) {
      return Emplacement.fromMap(maps[i]);
    });
  }

  void deleteEmplacement(String commune) async{
    await db.delete("EMPLACEMENT", where:"commune=$commune");
  }

  void updateEmplacement(Emplacement emplacement) async{
    String commune=emplacement.commune;
    await db.update("EMPLACEMENT", emplacement.toMap(), where:"commune=$commune");
  }
}