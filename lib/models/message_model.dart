class MessageModel {
  final String message;
  final DateTime dateTime;
  String? recipientName;
  final String deviceId;
  final String conversationId;
  MessageModel({
    required this.dateTime,
    required this.message,
    required this.deviceId,
    required this.recipientName,
    required this.conversationId,
  });

  static MessageModel fromMap(Map<String, dynamic> data) => MessageModel(
      dateTime: DateTime.parse(data['dateTime']),
      message: data['message'],
      recipientName: data['recipientName'],
      deviceId: data['deviceId'],
      conversationId: data['conversationId']);

  Map<String, dynamic> toMap() => {
        'message': message,
        'dateTime': dateTime.toIso8601String(),
        'deviceId': deviceId,
        'recipientName': recipientName,
        'conversationId': conversationId
      };
}
