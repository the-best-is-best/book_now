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
      : id = json['id'].toInt(),
        recordId = json['record_id'].toInt(),
        tableName = json['table_name'],
        action = json['action'];
}
