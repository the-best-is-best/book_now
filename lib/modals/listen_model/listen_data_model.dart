class ListenDataModel {
  int id;
  int recordId;
  String tableName;
  String action;

  ListenDataModel(
      {required this.id,
      required this.action,
      required this.recordId,
      required this.tableName});

  ListenDataModel.fromJson(Map<dynamic, dynamic> json)
      : id = int.parse(json['id'].toString()),
        recordId = int.parse(json['record_id'].toString()),
        tableName = json['table_name'],
        action = json['action'];
}
