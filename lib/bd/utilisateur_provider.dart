import 'package:flutter/foundation.dart';
import 'package:sae_mobile/model/utilisateur.dart';

class UtilisateurProvider extends ChangeNotifier {
  final db;
  final supabase;

  Utilisateur? utilisateur;

  UtilisateurProvider({required this.db, required this.supabase});
  UtilisateurProvider.supabaseOnly({required this.supabase}) : db = null;

  Future<void> insertUtilisateurSupabase(Utilisateur user) async {
    await supabase.from("utilisateur").insert(user.toMap());
  }

  Future<Utilisateur?> getUtilisateurFromId(int idUtilisateur) async {
    final results =
        await db.query("utilisateur", where: "idutilisateur=$idUtilisateur");

    if (results.isNotEmpty) {
      return Utilisateur.fromMap(results.first);
    }
    return null;
  }

  Future<Utilisateur?> getUtilisateurFromIdSupabase(int idUtilisateur) async {
    final data = await supabase.from("utilisateur").select().eq("idutilisateur", idUtilisateur).maybeSingle();

    if (data == null) {
      return null; 
    }
    return Utilisateur.fromMap(data);
  }

  Future<Utilisateur?> getUtilisateurFromPseudoPassword(
      String pseudo, String password) async {
    final List<dynamic> data = await supabase.from("utilisateur").select().eq("pseudo", pseudo).eq("motdepasse", password);

    if (data.isNotEmpty) {
      final map = data.first as Map<String, dynamic>;
      utilisateur = Utilisateur.fromMap(map);
    } else {
      utilisateur = null;
    }
    return utilisateur;
  }

  Future<List<Utilisateur>> getUtilisateurs() async {
    final results = await db.query("utilisateur");
    return results.map<Utilisateur>((map) => Utilisateur.fromMap(map)).toList();
  }

  Future<List<Utilisateur>> getUtilisateursSupabase() async {
    final List<dynamic> data = await supabase.from("utilisateur").select();
    return data.map<Utilisateur>((map) => Utilisateur.fromMap(map as Map<String, dynamic>)).toList();
  }

  Future<void> deleteUtilisateurSupabase(int idUtilisateur) async {
    await supabase.from("utilisateur").delete().eq("idutilisateur", idUtilisateur);
  }

  Future<void> updateUtilisateurSupabase(Utilisateur user) async {
    await supabase.from("utilisateur").update(user.toMap()).eq("idutilisateur", user.idUtilisateur);
  }
}
