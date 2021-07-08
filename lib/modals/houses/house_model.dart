class HouseModel {
  int id;
  String name;
  int floor;

  HouseModel({
    required this.id,
    required this.name,
    required this.floor,
  });

  HouseModel.fromJson(Map<String, dynamic> json)
      : id = json['id'].toInt(),
        name = json['name'],
        floor = json['floor'].toInt();
}
