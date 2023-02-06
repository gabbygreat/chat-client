class MessageModel {
  final String message;
  final DateTime dateTime;
  final bool isSender;
  MessageModel({
    required this.dateTime,
    required this.message,
    required this.isSender,
  });

  static MessageModel fromMap(Map<String, dynamic> data) => MessageModel(
        dateTime: DateTime.parse(data['dateTime']),
        message: data['message'],
        isSender: data['isSender'],
      );
}
