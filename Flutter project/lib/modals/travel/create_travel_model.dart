class CreateTravelModel {
  String name;

  CreateTravelModel({
    required this.name,
  });
  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
