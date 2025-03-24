class TablesBd{
  static Future<void> addTables(db) async {
    db.execute("create table TEST(idTest int primary key)");
    db.execute("insert into TEST values(1)");
    db.execute("insert into TEST values(2)");
    final List<Map<String, Object?>> dogMaps = await db.query('TEST');
    print(dogMaps);
  }
}