class RoomsModel {
  int id;
  String name;
  int houseId;
  int numbersOfBed;

  RoomsModel({
    required this.id,
    required this.name,
    required this.houseId,
    required this.numbersOfBed,
  });
  RoomsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'].toInt(),
        name = json['name'],
        houseId = json['house_id'].toInt(),
        numbersOfBed = json['numbers_of_bed'].toInt();
}
