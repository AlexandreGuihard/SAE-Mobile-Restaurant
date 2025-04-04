class Cuisine {
  int id;
  String type;

  Cuisine({required this.id, required this.type});

  Map<String,dynamic> toMap(){
    return {"idcuisine":id, "typecuisine":type};
  }

  factory Cuisine.fromMap(Map<String, dynamic> map) {
    return Cuisine(id: map['idcuisine'], type: map['typecuisine']);
  }

  String toString(){
    return "Cuisine: id=>$id, type=>$type";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is Cuisine &&
              other.id == id &&
              other.type == type);

  @override
  int get hashCode => id.hashCode ^ type.hashCode;
}