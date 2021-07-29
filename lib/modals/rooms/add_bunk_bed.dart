class AddBunkBed {
  int houseId;
  int floor;
  int room;
  int numbersOfBed;
  int bunkBed;

  AddBunkBed({
    required this.houseId,
    required this.floor,
    required this.room,
    required this.numbersOfBed,
    required this.bunkBed,
  });

  Map<String, dynamic> toJson() => {
        'house_id': houseId,
        'floor': floor,
        'room': room,
        'numbers_of_bed': numbersOfBed,
        'bunk_bed': bunkBed,
      };
}
