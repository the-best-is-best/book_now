class ListenDataModel {
  int id;
  int recordId;
  String tableName;
  String action;
  String date;

  ListenDataModel({
    required this.id,
    required this.action,
    required this.recordId,
    required this.tableName,
    required this.date,
  });

  ListenDataModel.fromJson(Map<dynamic, dynamic> json)
      : id = int.parse(json['id'].toString()),
        recordId = int.parse(json['record_id'].toString()),
        tableName = json['table_name'],
        action = json['action'],
        date = json['date'].toString();

  // Map<String, dynamic> toJson() => {
  //       'record_id': recordId,
  //       'table_name': tableName,
  //       'action': action,
  //       'date': date
  //     };
}
