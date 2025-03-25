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

  @override
  String toString() {
    return "Restaurant{id: $id, type: $type}";
  }
}