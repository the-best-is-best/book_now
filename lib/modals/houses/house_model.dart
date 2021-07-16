class HouseModel {
  int id;
  String name;
  int floor;

  HouseModel({
    required this.id,
    required this.name,
    required this.floor,
  });

  HouseModel.fromJson(Map<dynamic, dynamic> json)
      : id = int.parse(json['id'].toString()),
        name = json['name'],
        floor = int.parse(json['floor'].toString());

  // Map<String, dynamic> toJson() => {
  //       'name': name,
  //       'floor': floor,
  //     };
}
