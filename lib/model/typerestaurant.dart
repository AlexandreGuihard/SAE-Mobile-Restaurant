class TypeRestaurant {
  int id;
  String type;

  TypeRestaurant({required this.id, required this.type});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type
    };
  }

  @override
  String toString() {
    return "Restaurant{id: $id, type: $type}";
  }
}