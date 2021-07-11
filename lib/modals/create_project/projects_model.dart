class ProjectsModel {
  int id;
  String projectName;
  DateTime endDate;

  ProjectsModel({
    required this.id,
    required this.projectName,
    required this.endDate,
  });

  ProjectsModel.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id'].toString()),
        projectName = json['project_name'],
        endDate = DateTime.parse(json['end_date']);
}
