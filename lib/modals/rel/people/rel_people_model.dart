class RelPeopleModel {
  int id;
  String peopleName;
  int projectId;
  int paid;
  int support;
  int travelId;
  bool bones;
  int houseId;
  int roomId;
  int floor;

  RelPeopleModel({
    required this.id,
    required this.peopleName,
    required this.projectId,
    required this.houseId,
    required this.bones,
    required this.paid,
    required this.roomId,
    required this.support,
    required this.travelId,
    required this.floor,
  });
  RelPeopleModel.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id'].toString()),
        peopleName = json['people_name'],
        projectId = int.parse(json['project_id'].toString()),
        paid = int.parse(json['paid'].toString()),
        support = int.parse(json['support'].toString()),
        travelId = int.parse(json['travel_id'].toString()),
        bones = int.parse(json['coupons'].toString()) == 1 ? true : false,
        houseId = int.parse(json['house_id'].toString()),
        roomId = int.parse(json['room_id'].toString()),
        floor = int.parse(json['floor'].toString());
}
