class CreateListenModel {
  int recordId;
  String tableName;
  String action;
  String date;

  CreateListenModel({
    required this.action,
    required this.recordId,
    required this.tableName,
    required this.date,
  });
  Map<String, dynamic> toJson() => {
        'record_id': recordId,
        'table_name': tableName,
        'action': action,
        'date': date
      };
}
