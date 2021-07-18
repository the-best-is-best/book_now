class TravelModel {
  int id;
  int name;

  TravelModel({
    required this.id,
    required this.name,
  });
  TravelModel.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id'].toString()),
        name = int.parse(json['name'].toString());
}
