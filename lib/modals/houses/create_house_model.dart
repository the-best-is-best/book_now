class CreateHouseModel {
  String name;

  CreateHouseModel({
    required this.name,
  });
  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
