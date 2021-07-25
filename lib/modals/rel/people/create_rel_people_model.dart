class CreateRelPeopleModel {
  int personId;
  int projectId;
  int paid;
  int support;
  int travel;
  int bones;
  int houseId;
  int roomId;

  CreateRelPeopleModel({
    required this.personId,
    required this.projectId,
    required this.houseId,
    required this.bones,
    required this.paid,
    required this.roomId,
    required this.support,
    required this.travel,
  });

  Map<String, dynamic> toJson() => {
        'person_id': personId,
        'project_id': projectId,
        'paid': paid,
        'support': support,
        'travel': travel,
        'bones': bones,
        'house_id': houseId,
        'room_id': roomId
      };
}
