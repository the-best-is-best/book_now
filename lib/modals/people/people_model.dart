class PeopleModel {
  int id;
  String name;
  int tel;
  String city;

  PeopleModel({
    required this.id,
    required this.name,
    required this.tel,
    required this.city,
  });
  PeopleModel.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id'].toString()),
        name = json['name'],
        tel = int.parse(json['tel'].toString()),
        city = json['city'];
}
