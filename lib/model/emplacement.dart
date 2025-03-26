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

  String toString(){
    return "Emplacement: $commune, $departement ($numDepartement)";
  }
}