class CreateProjectModel {
  String projectName;
  int price;
  int house;
  String endDate;

  CreateProjectModel({
    required this.projectName,
    required this.price,
    required this.house,
    required this.endDate,
  });

  Map<String, dynamic> toJson() => {
        'project_name': projectName,
        'price': price,
        'house': house,
        'end_date': endDate,
      };
}
