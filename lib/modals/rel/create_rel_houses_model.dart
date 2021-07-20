class CreateRelHousesModel {
  int projectId;
  int houseId;
  bool active;

  CreateRelHousesModel({
    required this.projectId,
    required this.houseId,
    required this.active,
  });

  Map<String, dynamic> toJson() => {
        'project_id': projectId,
        'house_id': houseId,
        'active': active,
      };
}
