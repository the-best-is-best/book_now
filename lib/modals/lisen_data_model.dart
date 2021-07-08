class LisenDataModel {
  int id;
  int recordId;
  String tableName;
  String action;

  LisenDataModel(
      {required this.id,
      required this.action,
      required this.recordId,
      required this.tableName});

  LisenDataModel.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id'].toString()),
        recordId = int.parse(json['record_id'].toString()),
        tableName = json['table_name'],
        action = json['action'];
}
