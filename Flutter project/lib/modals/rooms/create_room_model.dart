class CreateRoomModel {
  String name;
  int houseId;
  int floor;
  int numbersOfBed;

  CreateRoomModel({
    required this.name,
    required this.houseId,
    required this.floor,
    required this.numbersOfBed,
  });
  Map<String, dynamic> toJson() => {
        'name': name,
        'house_id': houseId,
        'floor': floor,
        'numbers_of_bed': numbersOfBed,
      };
}
