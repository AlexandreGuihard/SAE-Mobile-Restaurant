class Emplacement {
  String commune;
  int numDepartement;
  String departement;

  Emplacement({
    required this.commune,
    required this.numDepartement,
    required this.departement});

  Map<String,dynamic> toMap(){
    return {"commune":commune, "numDepartement":numDepartement, "departement":departement};
  }

  factory Emplacement.fromMap(Map<String, dynamic> map) {
    return Emplacement(
      commune: map['commune'],
      numDepartement: map['numDepartement'],
      departement: map['departement']
    );
  }

  String toString(){
    return "Emplacement: $commune, $departement ($numDepartement)";
  }
}