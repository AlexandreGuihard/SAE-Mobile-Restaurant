class TablesBd{
  static Future<void> addTables(db) async {
    db.execute("create table cuisine(idcuisine int primary key, typecuisine varchar(42) unique)");
    db.execute("create table typerestaurant(idtype int primary key, typerestaurant varchar(42))");
    db.execute("create table emplacement(commune varchar(42) primary key, numdepartement int, departement varchar(42))");
    db.execute("create table restaurant(idrestaurant int primary key, idtype int, nomrestaurant varchar(42), horaires varchar(42), siret varchar(25) unique, numtel varchar(10) unique, urlweb varchar(100), commune varchar(42), vegetarien boolean, vegan boolean, entreefauteuilroulant boolean, accesinternet boolean, marquerestaurant varchar(42), nbetoiles int check (nbetoiles<=5), urlfacebook varchar(100), foreign key (idtype) references typerestaurant (idtype), foreign key (commune) references emplacement (commune))");
    db.execute("create table appartenir(idrestaurant int, idcuisine int, primary key(idrestaurant, idcuisine), foreign key (idrestaurant) references restaurant (idrestaurant), foreign key (idcuisine) references cuisine (idcuisine))");
    db.execute("create table utilisateur (idutilisateur int primary key, pseudo varchar(24), motdepasse varchar(24), moderateur boolean default false)");
    db.execute("create table donner(idutilisateur int, dateavis date, idrestaurant int, avis varchar(100), note int, primary key(idutilisateur, dateavis, idrestaurant), foreign key (idutilisateur) references utilisateur (idutilisateur), foreign key (idrestaurant) references restaurant (idrestaurant))");
    print("Tables créees");
  }
}