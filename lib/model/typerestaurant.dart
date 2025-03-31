class TypeRestaurant {
  int id;
  String type;

  TypeRestaurant({required this.id, required this.type});

  Map<String, dynamic> toMap() {
    return {
      'idType': id,
      'typeRestaurant': type
    };
  }

  factory TypeRestaurant.fromMap(Map<String, dynamic> map) {
    return TypeRestaurant(id: map['idType'], type: map['typeRestaurant']);
  }

  @override
  String toString() {
    return "Restaurant{id: $id, type: $type}";
  }
}