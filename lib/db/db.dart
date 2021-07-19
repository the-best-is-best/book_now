// import 'package:sqflite/sqflite.dart';

// class DB {
//   static late Database db;
//   static Future<void> init() async {
//     db = await openDatabase('book_now.db', version: 1,
//             onCreate: (database, version) {
//       database.execute(
//           'CREATE TABLE book_now_log (id integer PRIMARY KEY , record_id integer , action TEXT , table_name TEXT , date  TEXT)');

//       database.execute(
//           'CREATE TABLE houses (id integer PRIMARY KEY , name TEXT , floor integer )');

//       database.execute(
//           'CREATE TABLE rooms (id integer PRIMARY KEY , tel NUMERIC , city TEXT )');

//       database.execute(
//           'CREATE TABLE people (id integer PRIMARY KEY, name NUMERIC , house_id integer , floor integer ,numbers_of_bed integer )');
//     }, onOpen: (database) {})
//         .catchError((error) {});
//   }

//   static Future insertToDB(
//       {required String tableName, required Map<String, Object?> data}) async {
//     await db.transaction((txn) async {
//       return Future.delayed(Duration(seconds: 1), () async {
//         return await txn.insert(tableName, data).then((value) {
//           return value;
//         }).catchError((onError) {});
//       });
//     });
//   }

//   static Future<List<Map>> getDataFromDB(table) {
//     List<Map<dynamic, dynamic>> data = [];
//     return Future.delayed(Duration(seconds: 1), () async {
//       data = await db.query(table);
//       return data;
//     });
//   }

//   static Future<int> updateData({
//     required table,
//     required Map<String, Object?> data,
//   }) async {
//     return Future.delayed(Duration(seconds: 1), () async {
//       return await db
//           .update(table, data, where: 'id = ?', whereArgs: [data['id']]);
//     });
//   }

//   static Future deleteData<int>(
//       {required String table, required int id}) async {
//     return Future.delayed(Duration(seconds: 1), () async {
//       return await db.delete(table, where: 'id = ?', whereArgs: [id]);
//     });
//   }

//   static Future getLastId({required table}) async {
//     var data =
//         await db.rawQuery("SELECT * FROM $table ORDER BY id DESC LIMIT 1");
//     return data[0]['id'];
//   }
// }