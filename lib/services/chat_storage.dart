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
  senderDeviceId TEXT NOT NULL,
  recipientName TEXT NULL,
  conversationId TEXT NOT NULL,
  messageId TEXT NOT NULL,
  sortConversationId TEXT NOT NULL,
  recipientDeviceId TEXT NOT NULL
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
        senderDeviceId,
        recipientName,
        conversationId,
        messageId,
        sortConversationId,
        recipientDeviceId
        )
        VALUES(?, ?, ?, ?, ?, ?, ?, ?);
        ''',
        [
          chatList.message,
          chatList.dateTime.toIso8601String(),
          chatList.senderDeviceId,
          chatList.recipientName,
          chatList.conversationId,
          chatList.messageId,
          chatList.sortConversationId,
          chatList.recipientDeviceId,
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
    String deviceId = (await PlatformDeviceId.getDeviceId)!;

    try {
      if (message.conversationId.split('-').contains(deviceId)) {
        if (message.recipientDeviceId == deviceId) {
          await create([message]);
        } else {
          await db.rawUpdate(
              "UPDATE $chatTableName SET dateTime = '${message.dateTime.toIso8601String()}' WHERE messageId = '${message.messageId}'");
        }
      }
    } on DatabaseException {
      debugPrint('Error updating chat');
    }
  }

  Future<List<MessageModel>> readLocalConversation(
      MessageModel messageInfo) async {
    final db = await instance.database;
    final conversation = await db.rawQuery(
        "SELECT * FROM $chatTableName WHERE sortConversationId = '${messageInfo.sortConversationId}'");
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
        "SELECT * FROM $chatTableName GROUP BY sortConversationId ORDER BY dateTime DESC");
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
