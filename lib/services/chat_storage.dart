import '/utils/utils.dart';
import 'package:path/path.dart' as p;

const String chatTableName = 'chat_table';

class LocalChatHistory {
  static final LocalChatHistory instance = LocalChatHistory._init();
  static Database? _database;
  LocalChatHistory._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('chat.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    Directory? directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      directory = await getApplicationSupportDirectory();
    }
    final path = p.join(directory!.path, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE $chatTableName (
  message TEXT NOT NULL,
  dateTime TEXT NOT NULL,
  deviceId TEXT NOT NULL,
  displayName TEXT NULL,
  conversationId TEXT NOT NULL
  )
''');
  }

  Future<void> create(List<MessageModel> messageList) async {
    final db = await instance.database;
    var batch = db.batch();
    for (MessageModel chatList in messageList) {
      batch.rawInsert(
        '''INSERT OR IGNORE INTO $chatTableName (
        message,
        dateTime,
        deviceId,
        displayName,
        conversationId
        )
        VALUES(?, ?, ?, ?, ?);
        ''',
        [
          chatList.message,
          chatList.dateTime.toIso8601String(),
          chatList.deviceId,
          chatList.displayName,
          chatList.conversationId,
        ],
      );
    }

    await batch.commit(noResult: true);
  }

  Future<void> updateLocal({
    required MessageModel message,
  }) async {
    //log(" hey chat list updated");
    final db = await instance.database;
    try {
      await db.rawUpdate(
          "UPDATE $chatTableName SET dateTime = '${message.dateTime.toIso8601String()}' WHERE conversationId = '${message.conversationId}'");
    } on DatabaseException {
      debugPrint('Error updating chat');
      // await db.rawDelete(
      //     "DELETE FROM $chatTableName WHERE conversationId = '${message.conversationId}'");
      // Flushbar(
      //   duration: const Duration(seconds: 3),
      //   message: "Message not found",
      //   backgroundColor: Colors.red,
      // ).show(globalContext);
    }
  }

  Future<List<MessageModel>> readLocalConversation(
      MessageModel messadeInfo) async {
    final db = await instance.database;

    final conversation =
        await db.rawQuery("SELECT * FROM $chatTableName ORDER BY dateTime");
    List<MessageModel> result = [];
    for (var i in conversation) {
      result.add(MessageModel.fromMap(i));
    }
    return result;
  }

  Future<List<MessageModel>> getLastMessageList() async {
    final db = await instance.database;
// SELECT * FROM chat_table WHERE date IN (SELECT MAX(date) FROM chat_table a WHERE ((fromuserid=$chatUserId AND fromplaceid=$chatPlaceId) OR (touserid=$chatUserId AND toplaceid=$chatPlaceId)) GROUP BY conversationId) GROUP BY date ORDER BY date DESC
    final conversation = await db.rawQuery(
        "SELECT * FROM $chatTableName WHERE dateTime IN (SELECT MAX(dateTime) FROM $chatTableName) GROUP BY deviceId ORDER BY dateTime DESC");
    List<MessageModel> result = [];
    for (var i in conversation) {
      result.add(MessageModel.fromMap(i));
    }
    return result;
  }

  Future<void> close() async {
    final db = await instance.database;
    _database = null;
    db.close();
  }
}
