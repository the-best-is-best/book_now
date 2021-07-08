class HouseModel {
  int id;
  String name;

  HouseModel({
    required this.id,
    required this.name,
  });

  HouseModel.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id'].toString()),
        name = json['name'];
}
