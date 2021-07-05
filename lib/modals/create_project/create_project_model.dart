class CreateProjectModel {
  String projectName;
  String houseName;
  String endDate;

  CreateProjectModel({
    required this.projectName,
    required this.houseName,
    required this.endDate,
  });

  Map<String, dynamic> toJson() => {
        'project_name': projectName,
        'house_name': houseName,
        'end_date': endDate,
      };
}
