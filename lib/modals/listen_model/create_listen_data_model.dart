class CreateListenModel {
  int recordId;
  String tableName;
  String action;

  CreateListenModel({
    required this.action,
    required this.recordId,
    required this.tableName,
  });
  Map<String, dynamic> toJson() => {
        'record_id': recordId,
        'table_name': tableName,
        'action': action,
      };
}
