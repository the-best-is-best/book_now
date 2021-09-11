class CreateRelPeopleModel {
  int peopleId;
  int projectId;
  int paid;
  int support;
  int travelId;
  int bones;
  int houseId;
  int roomId;
  String note;

  CreateRelPeopleModel({
    required this.peopleId,
    required this.projectId,
    required this.houseId,
    required this.bones,
    required this.paid,
    required this.roomId,
    required this.support,
    required this.travelId,
    required this.note,
  });

  Map<String, dynamic> toJson() => {
        'people_id': peopleId,
        'project_id': projectId,
        'paid': paid,
        'support': support,
        'travel_id': travelId,
        'bones': bones,
        'house_id': houseId,
        'room_id': roomId,
        'note': note,
      };
}
