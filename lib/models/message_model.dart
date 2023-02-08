class MessageModel {
  final String message;
  final DateTime dateTime;
  final String? recipientName;
  final String? senderName;
  final String? senderSocketId;
  final String messageId;
  final String conversationId;
  final String senderDeviceId;
  final String recipientDeviceId;
  final bool isRequest;
  final String sortConversationId;
  MessageModel({
    required this.dateTime,
    required this.message,
    required this.senderDeviceId,
    required this.recipientName,
    required this.senderName,
    required this.messageId,
    this.isRequest = false,
    this.senderSocketId,
    required this.recipientDeviceId,
    required this.conversationId,
    required this.sortConversationId,
  });

  static MessageModel fromMap(Map<String, dynamic> data) => MessageModel(
      dateTime: DateTime.parse(data['dateTime']),
      message: data['message'],
      recipientName: data['recipientName'],
      senderName: data['senderName'],
      recipientDeviceId: data['recipientDeviceId'],
      senderDeviceId: data['senderDeviceId'],
      sortConversationId: data['sortConversationId'],
      messageId: data['messageId'],
      conversationId: data['conversationId']);

  Map<String, dynamic> toMap() => {
        'message': message,
        'dateTime': dateTime.toIso8601String(),
        'senderDeviceId': senderDeviceId,
        'sortConversationId': sortConversationId,
        'recipientName': recipientName,
        'senderName': senderName,
        'recipientDeviceId': recipientDeviceId,
        'conversationId': conversationId,
        'messageId': messageId,
      };
}
