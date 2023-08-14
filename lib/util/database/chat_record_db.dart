import 'package:pet_community/models/chat/chat_record_model.dart';
import 'package:pet_community/util/tools.dart';

import 'package:path/path.dart';

class ChatRecordDB {
  static Database? db;

  ///初始化聊天记录数据库
  static Future<Database?> initDatabase(int userId) async {
    debugPrint("userId2--------->${userId}");

    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'ChatRecord$userId.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // debugPrint("db---2------>${db}");
        // When creating the db, create the table
        await db.execute(
          'CREATE TABLE chat_record_$userId (chat_id INTEGER PRIMARY KEY AUTOINCREMENT, sender_id INTEGER, receiver_id INTEGER, '
          'message TEXT, type INTEGER,  timestamp INTEGER, other_id INTEGER)',
        );
      },
    );
    debugPrint("db--------->${db?.database}");

    return db;
  }

  ///保存聊天记录到db
  static Future<int?> insertData(int userId, ChatRecordModel crm, int otherId) async {
    debugPrint("userId-----insertData---->${userId}");
    Map<String, Object?> map = {
      "sender_id": crm.userId,
      "receiver_id": crm.receiverId,
      "message": crm.data.toString(),
      "type": crm.type,
      "timestamp": crm.sendTime,
      "other_id": otherId,
    };
    int? result = await db?.insert("chat_record_$userId", map);
    debugPrint("result--------->${result}");
    return result;
  }

  ///查询最近10条聊天记录
  static Future<List<ChatRecordModel>> queryChatRecord(int? userId, int otherId, {int page = 1, int count = 10}) async {
    List<Map<String, Object?>>? data;
    List<ChatRecordModel> list = [];
    if (userId != null) {
      data = await db?.rawQuery(
        'SELECT * FROM chat_record_$userId WHERE other_id = $otherId  ORDER BY timestamp  DESC '
        'LIMIT ${(page - 1) * count},$count ',
      );
      if (data != null) {
        for (var element in data) {
          ChatRecordModel chatRecordModel = ChatRecordModel.fromMap(element);
          list.add(chatRecordModel);
        }
        // ChatRecordModel chatRecordMode = ChatRecordModel.fromMap(data[0]);
      }
    }
    debugPrint("data db--------->${data?.length}");
    return list;
  }

  ///分组查询最近一条记录
 static  groupByQueryRecentOneRecord(int? userId) async {
    List<Map<String, Object?>>? data;

    data = await db?.rawQuery(
      'SELECT *, MAX(timestamp) FROM chat_record_$userId GROUP BY other_id ',
    );
    debugPrint("data--group by------->${data}");
  }

}
