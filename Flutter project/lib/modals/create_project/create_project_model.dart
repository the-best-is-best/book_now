class CreateProjectModel {
  String projectName;
  int price;
  int houseId;
  String endDate;

  CreateProjectModel({
    required this.projectName,
    required this.price,
    required this.houseId,
    required this.endDate,
  });

  Map<String, dynamic> toJson() => {
        'project_name': projectName,
        'price': price,
        'house_id': houseId,
        'end_date': endDate,
      };
}
