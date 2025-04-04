class TypeRestaurant {
  int id;
  String type;

  TypeRestaurant({required this.id, required this.type});

  Map<String, dynamic> toMap() {
    return {
      'idtype': id,
      'type': type
    };
  }

  factory TypeRestaurant.fromMap(Map<String, dynamic> map) {
    return TypeRestaurant(id: map['idtype'], type: map['type']);
  }

  @override
  String toString() {
    return "Restaurant{id: $id, type: $type}";
  }
}