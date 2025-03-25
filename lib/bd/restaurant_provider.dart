import 'package:sae_mobile/model/restaurant.dart';

class RestaurantProvider {
  final db;

  RestaurantProvider({required this.db});

  // Selects
  Future<List<Restaurant>> restaurants() async {
    return await db.query('RESTAURANT');
  }

  Future<Restaurant> restaurant(int id) async {
    return await db.query(
        'RESTAURANT',
        where: 'idRestaurant = ?',
        whereArgs: [id]
    );
  }

  // Inserts
  Future<Restaurant> insert(Restaurant r) async {
    r.id = await db.insert("RESTAURANT", r.toMap());
    return r;
  }

  // Update
  Future<int> update(Restaurant r) async {
    return await db.update(
        "RESTAURANT",
        r.toMap(),
        where: 'idRestaurant = ?',
        whereArgs: [r.id]
    );
  }

  // Delete
  Future<int> delete(Restaurant r) async {
    return await db.delete(
      "RESTAURANT",
      where: 'idRestaurant = ?',
      whereArgs: [r.id]
    );
  }
}