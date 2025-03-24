import 'package:sae_mobile/model/typerestaurant.dart';

class TypeRestaurantProvider {
  final db;

  TypeRestaurantProvider({required this.db});

  // Selects
  Future<List<TypeRestaurant>> restaurants() async {
    return await db.query('TYPERESTAURANT');
  }

  Future<TypeRestaurant> restaurant(int id) async {
    return await db.query(
        'TYPERESTAURANT',
        where: 'idType = ?',
        whereArgs: [id]
    );
  }

  // Inserts
  Future<TypeRestaurant> insert(TypeRestaurant type) async {
    type.id = await db.insert("TYPERESTAURANT", type.toMap());
    return type;
  }

  // Update
  Future<int> update(TypeRestaurant type) async {
    return await db.update(
        "TYPERESTAURANT",
        type.toMap(),
        where: 'idType = ?',
        whereArgs: [type.id]
    );
  }

  // Delete
  Future<int> delete(TypeRestaurant type) async {
    return await db.delete(
        "TYPERESTAURANT",
        where: 'idType = ?',
        whereArgs: [type.id]
    );
  }
}