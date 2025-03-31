import 'package:flutter/foundation.dart';

import '../model/utilisateur.dart';

class UtilisateurProvider extends ChangeNotifier{
  final db;
  final supabase;

  UtilisateurProvider({required this.db, required this.supabase});

  void insertUtilisateur(Utilisateur utilisateur) async{
    await db.insert("UTILISATEUR", utilisateur.toMap());
  }

  Future<Utilisateur> getUtilisateurFromId(int idUtilisateur) async{
    return await db.query("UTILISATEUR", where:"idUtilisateur=$idUtilisateur");
  }

  Future<List<Utilisateur>> getUtilisateurs() async{
    return await db.query("UTILISATEUR");
  }

  void deleteUtilisateur(int idUtilisateur) async{
    await db.delete("UTILISATEUR", where: "idUtilisateur=$idUtilisateur");
  }

  void updateUtilisateur(Utilisateur utilisateur) async{
    int idUtilisateur=utilisateur.idUtilisateur;
    await db.update("UTILISATEUR", utilisateur.toMap(), where: "idUtilisateur=$idUtilisateur");
  }
}