class CreateProjectModel {
  String projectName;
  int price;
  String endDate;

  CreateProjectModel({
    required this.projectName,
    required this.price,
    required this.endDate,
  });

  Map<String, dynamic> toJson() => {
        'project_name': projectName,
        'price': price,
        'end_date': endDate,
      };
}
