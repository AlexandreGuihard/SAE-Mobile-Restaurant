class Cuisine {
  int id;
  String type;

  Cuisine({required this.id, required this.type});

  Map<String,dynamic> toMap(){
    return {"id":id, "type":type};
  }

  String toString(){
    return "Cuisine: id=>$id, type=>$type";
  }
}