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
  isSender TEXT NOT NULL
  )
''');
  }

  Future<void> create(List<MessageModel> chatLists,
      {required String? photo, required String fullname}) async {
    final db = await instance.database;

    var batch = db.batch();
    for (MessageModel chatList in chatLists) {
      batch.rawInsert(
        '''INSERT OR IGNORE INTO $chatTableName (
        message,
        dateTime,
        isSender
        )
        VALUES(?, ?, ?);
        ''',
        [
          chatList.message,
          chatList.dateTime.toIso8601String(),
          chatList.isSender,
        ],
      );
    }

    await batch.commit(noResult: true);
  }

  Future<void> updateLocal({
    required int messageId,
    required String clientMessageId,
    required DateTime date,
  }) async {
    //log(" hey chat list updated");
    final db = await instance.database;
    try {
      await db.rawUpdate(
          "UPDATE $chatTableName SET messageId = $messageId, date = '${date.toIso8601String()}' WHERE clientMessageId = '$clientMessageId'");
    } on DatabaseException {
      await db.rawDelete(
          "DELETE FROM $chatTableName WHERE clientMessageId = '$clientMessageId'");
      // Flushbar(
      //   duration: const Duration(seconds: 3),
      //   message: "Message not found",
      //   backgroundColor: Colors.red,
      // ).show(globalContext);
    }
  }

  Future<List<MessageModel>> readLocalConversation(
      {required int userId, required int placeId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? chatPlaceId = prefs.getInt('chatPlaceId');
    if (chatPlaceId == null) {
      await prefs.setInt('chatPlaceId', prefs.getInt('placeId')!);
    }
    chatPlaceId = prefs.getInt('chatPlaceId');
    int? chatUserId = prefs.getInt('chatUserId');
    if (chatUserId == null) {
      await prefs.setInt('chatUserId', prefs.getInt('userid')!);
    }
    chatUserId = prefs.getInt('chatUserId');

    final db = await instance.database;
    final conversation = await db.rawQuery(
        "SELECT * FROM $chatTableName WHERE userId=$userId AND placeId=$placeId AND (toplaceid=$chatPlaceId OR toplaceid=$placeId) AND (myPlaceId=$chatPlaceId) AND (touserid = $chatUserId OR touserid=$userId) ORDER BY date DESC");

    List<MessageModel> result = [];
    for (var i in conversation) {
      result.add(MessageModel.fromMap(i));
    }
    return result;
  }

  Future<List<MessageModel>> getLastMessageList() async {
    final db = await instance.database;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? chatPlaceId = prefs.getInt('chatPlaceId');
    if (chatPlaceId == null) {
      await prefs.setInt('chatPlaceId', prefs.getInt('placeId')!);
    }
    chatPlaceId = prefs.getInt('chatPlaceId');
    int? chatUserId = prefs.getInt('chatUserId');
    if (chatUserId == null) {
      await prefs.setInt('chatUserId', prefs.getInt('userid')!);
    }
    chatUserId = prefs.getInt('chatUserId');

    final conversation = await db.rawQuery(
        "SELECT * FROM $chatTableName WHERE date IN (SELECT MAX(date) FROM $chatTableName a WHERE ((fromuserid=$chatUserId AND fromplaceid=$chatPlaceId) OR (touserid=$chatUserId AND toplaceid=$chatPlaceId)) GROUP BY conversationId) GROUP BY date ORDER BY date DESC");
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
