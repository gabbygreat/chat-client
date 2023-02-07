class MessageModel {
  final String message;
  final DateTime dateTime;
  final bool isSender;
  final String deviceId;
  final String conversationId;
  MessageModel({
    required this.dateTime,
    required this.message,
    required this.isSender,
    required this.deviceId,
    required this.conversationId,
  });

  static MessageModel fromMap(Map<String, dynamic> data) => MessageModel(
      dateTime: DateTime.parse(data['dateTime']),
      message: data['message'],
      isSender: data['isSender'] == 1 ? true : false,
      deviceId: data['deviceId'],
      conversationId: data['conversationId']);

  Map<String, dynamic> toMap() => {
        'message': message,
        'dateTime': dateTime.toIso8601String(),
        'isSender': isSender ? 1 : 0,
        'deviceId': deviceId,
        'conversationId': conversationId
      };
}
