class Cuisine {
  int id;
  String type;

  Cuisine({required this.id, required this.type});

  Map<String,dynamic> toMap(){
    return {"idCuisine":id, "typeCuisine":type};
  }

  factory Cuisine.fromMap(Map<String, dynamic> map) {
    return Cuisine(id: map['idCuisine'], type: map['typeCuisine']);
  }

  String toString(){
    return "Cuisine: id=>$id, type=>$type";
  }
}