class AddBunkBed {
  int houseId;
  int floor;
  int room;
  int bunkBed;

  AddBunkBed({
    required this.houseId,
    required this.floor,
    required this.room,
    required this.bunkBed,
  });

  Map<String, dynamic> toJson() => {
        'house_id': houseId,
        'floor': floor,
        'room': room,
        'bunk_bed': bunkBed,
      };
}
