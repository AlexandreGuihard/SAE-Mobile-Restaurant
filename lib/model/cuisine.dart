class Cuisine {
  int id;
  String type;

  Cuisine({required this.id, required this.type});

  Map<String,dynamic> toMap(){
    return {"idCuisine":id, "typeCuisine":type};
  }

  String toString(){
    return "Cuisine: id=>$id, type=>$type";
  }
}