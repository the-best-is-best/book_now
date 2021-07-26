class RelPeopleModel {
  int id;
  int peopleId;
  int projectId;
  int paid;
  int support;
  int travelId;
  bool bones;
  int houseId;
  int roomId;

  RelPeopleModel({
    required this.id,
    required this.peopleId,
    required this.projectId,
    required this.houseId,
    required this.bones,
    required this.paid,
    required this.roomId,
    required this.support,
    required this.travelId,
  });
  RelPeopleModel.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id'].toString()),
        peopleId = int.parse(json['people_id'].toString()),
        projectId = int.parse(json['project_id'].toString()),
        paid = int.parse(json['paid'].toString()),
        support = int.parse(json['support'].toString()),
        travelId = int.parse(json['travel_id'].toString()),
        bones = int.parse(json['bones'].toString()) == 1 ? true : false,
        houseId = int.parse(json['house_id'].toString()),
        roomId = int.parse(json['room_id'].toString());
}
