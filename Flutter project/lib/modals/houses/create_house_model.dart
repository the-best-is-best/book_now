class CreateHouseModel {
  String name;
  int floor;

  CreateHouseModel({
    required this.name,
    required this.floor,
  });
  Map<String, dynamic> toJson() => {
        'name': name,
        'floor': floor,
      };
}
