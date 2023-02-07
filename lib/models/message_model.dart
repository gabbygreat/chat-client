class MessageModel {
  final String message;
  final DateTime dateTime;
  final String? displayName;
  final String deviceId;
  final String conversationId;
  MessageModel({
    required this.dateTime,
    required this.message,
    required this.deviceId,
    required this.displayName,
    required this.conversationId,
  });

  static MessageModel fromMap(Map<String, dynamic> data) => MessageModel(
      dateTime: DateTime.parse(data['dateTime']),
      message: data['message'],
      displayName: data['displayName'],
      deviceId: data['deviceId'],
      conversationId: data['conversationId']);

  Map<String, dynamic> toMap() => {
        'message': message,
        'dateTime': dateTime.toIso8601String(),
        'deviceId': deviceId,
        'displayName': displayName,
        'conversationId': conversationId
      };
}
