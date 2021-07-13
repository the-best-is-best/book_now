class CreatePeopleModel {
  String name;
  int tel;
  String city;

  CreatePeopleModel({
    required this.name,
    required this.tel,
    required this.city,
  });
  Map<String, dynamic> toJson() => {
        'name': name,
        'tel': tel,
        'city': city,
      };
}
