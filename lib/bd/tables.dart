class TablesBd{
  static Future<void> addTables(db) async {
    db.execute("create table CUISINE(idCuisine int primary key, typeCuisine varchar(42) unique)");
    db.execute("create table TYPERESTAURANT(idType int primary key, typeRestaurant varchar(42))");
    db.execute("create table EMPLACEMENT(commune varchar(42) primary key, numDepartement int, departement varchar(42))");
    db.execute("create table RESTAURANT(idRestaurant int primary key, idType int, nomRestaurant varchar(42), horaires varchar(42), siret varchar(25) unique, numTel varchar(10) unique, urlWeb varchar(100), commune varchar(42), vegetarien boolean, vegan boolean, entreeFauteuilRoulant boolean, accesInternet boolean, marqueRestaurant varchar(42), nbEtoiles int check (nbEtoiles<=5), urlFacebook varchar(100), foreign key (idType) references TYPERESTAURANT (idType), foreign key (commune) references EMPLACEMENT (commune))");
    db.execute("create table APPARTENIR(idRestaurant int, idCuisine int, primary key(idRestaurant, idCuisine), foreign key (idRestaurant) references RESTAURANT (idRestaurant), foreign key (idCuisine) references CUISINE (idCuisine))");
    db.execute("create table UTILISATEUR (idUtilisateur int primary key, pseudo varchar(24), motDePasse varchar(24), moderateur boolean default false)");
    db.execute("create table DONNER(idUtilisateur int, dateAvis date, idRestaurant int, avis varchar(100), note int, primary key(idUtilisateur, dateAvis, idRestaurant), foreign key (idUtilisateur) references UTILISATEUR (idUtilisateur), foreign key (idRestaurant) references RESTAURANT (idRestaurant))");
    print("Tables créees");
  }
}