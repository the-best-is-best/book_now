class ProjectsModel {
  int id;
  String projectName;
  int price;
  DateTime endDate;

  ProjectsModel({
    required this.id,
    required this.projectName,
    required this.price,
    required this.endDate,
  });

  ProjectsModel.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id'].toString()),
        projectName = json['project_name'],
        price = int.parse(json['price'].toString()),
        endDate = DateTime.parse(json['end_date']);
}
