class RelPeopleModel {
  int id;
  String personName;
  int projectId;
  int paid;
  int support;
  String travel;
  bool bones;
  int houseId;
  int roomId;

  RelPeopleModel({
    required this.id,
    required this.personName,
    required this.projectId,
    required this.houseId,
    required this.bones,
    required this.paid,
    required this.roomId,
    required this.support,
    required this.travel,
  });
  RelPeopleModel.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id'].toString()),
        personName = json['person_name'],
        projectId = int.parse(json['project_id'].toString()),
        paid = int.parse(json['paid'].toString()),
        support = int.parse(json['support'].toString()),
        travel = json['travel'].toString(),
        bones = int.parse(json['bones'].toString()) == 1 ? true : false,
        houseId = int.parse(json['house_Id'].toString()),
        roomId = int.parse(json['room_id'].toString());
}
