import 'package:flutter/foundation.dart';
import 'package:sae_mobile/model/restaurant.dart';

import '../model/utilisateur.dart';

class UtilisateurProvider extends ChangeNotifier{
  final db;
  final supabase;

  Utilisateur? utilisateur;

  UtilisateurProvider({required this.db, required this.supabase});
  UtilisateurProvider.supabaseOnly({required this.supabase}) : db = null;

  void insertUtilisateur(Utilisateur utilisateur) async{
    await db.insert("utilisateur", utilisateur.toMap());
  }

  Future<Utilisateur> getUtilisateurFromId(int idUtilisateur) async{
    return await db.query("utilisateur", where:"idutilisateur=$idUtilisateur");
  }

  Future<Utilisateur> getUtilisateurFromIdSupabase(int idUtilisateur) async{
    final Map<String, dynamic> map=await supabase.from("utilisateur").select().eq("idutilisateur", idUtilisateur);
    return Utilisateur.fromMap(map);
  }

  Future<Utilisateur?> getUtilisateurFromPseudoPassword(String pseudo, String password) async{
    final List<Map<String, dynamic>> map=await supabase.from("utilisateur").select().eq("pseudo", pseudo).eq("motdepasse", password);

    if (map.isNotEmpty) {
      this.utilisateur = Utilisateur.fromMap(map.first);
    }
    return this.utilisateur;
  }

  Future<List<Utilisateur>> getUtilisateurs() async{
    return await db.query("utilisateur");
  }

  Future<List<Utilisateur>> getUtilisateursSupabase() async{
    final List<Map<String, dynamic>> maps=await supabase.from("utilisateur").select();
    return List.generate(maps.length, (i){
      return Utilisateur.fromMap(maps[i]);
    });
  }

  void deleteUtilisateur(int idUtilisateur) async{
    await db.delete("utilisateur", where: "idutilisateur=$idUtilisateur");
  }

  void updateUtilisateur(Utilisateur utilisateur) async{
    int idUtilisateur=utilisateur.idUtilisateur;
    await db.update("utilisateur", utilisateur.toMap(), where: "idutilisateur=$idUtilisateur");
  }
}