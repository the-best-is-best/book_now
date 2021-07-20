class RelHousesModel {
  int id;
  int projectId;
  int houseId;
  bool active;

  RelHousesModel({
    required this.id,
    required this.projectId,
    required this.houseId,
    required this.active,
  });
  RelHousesModel.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id'].toString()),
        projectId = int.parse(json['project_id'].toString()),
        houseId = int.parse(json['house_id'].toString()),
        active = json['active'] == 1 ? true : false;
}
