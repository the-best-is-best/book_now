class RoomsModel {
  int id;
  int name;
  int houseId;
  int floor;
  int numbersOfBed;
  int bunkBed;

  RoomsModel({
    required this.id,
    required this.name,
    required this.houseId,
    required this.floor,
    required this.numbersOfBed,
    required this.bunkBed,
  });
  RoomsModel.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id'].toString()),
        name = int.parse(json['name'].toString()),
        houseId = int.parse(json['house_id'].toString()),
        floor = int.parse(json['floor'].toString()),
        numbersOfBed = int.parse(json['numbers_of_bed'].toString()),
        bunkBed = int.parse(json['bunk_bed'].toString());
}
