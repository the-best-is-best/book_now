class HouseModel {
  int id;
  String name;
  DateTime projectId;

  HouseModel({
    required this.id,
    required this.name,
    required this.projectId,
  });

  HouseModel.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id'].toString()),
        name = json['house_name'],
        projectId = DateTime.parse(json['project_id']);
}
