import '/utils/utils.dart';

class SocketServices {
  static final SocketServices instance = SocketServices._init();
  static Socket? _socket;
  SocketServices._init();

  Socket get socket {
    if (_socket != null) return _socket!;
    _socket = io(ChatConstant.baseUrl,
        OptionBuilder().setTransports(['websocket']).build());
    return _socket!;
  }

  void connectAndListen(WidgetRef ref) async {
    String senderDeviceId = (await PlatformDeviceId.getDeviceId)!;

    socket.auth = {'senderDeviceId': senderDeviceId};
    socket.onConnect((data) {
      debugPrint(socket.id);
      GlobalVariable.socketId = socket.id;
    });
    socket.onError((data) => debugPrint('Error => $data'));
    socket.onDisconnect((data) => debugPrint('Disconnected'));
    socket.on('message', (data) => receiveMessage(data, ref));
    socket.on('request', (data) => sendRequest(data, ref));
    socket.on('accept', (data) => sendAcceptedRequest(data, ref));
  }

  void sendMessage(MessageModel message) {
    socket.emit(
      'message',
      message.toMap(),
    );
  }

  receiveMessage(dynamic data, WidgetRef ref) async {
    MessageModel messageModel = MessageModel.fromMap(data);
    await LocalChatHistory.instance.updateLocal(message: messageModel);
    await ref.read(messageProvider.notifier).getMessages(messageModel);
    await ref.read(lastMessageProvider.notifier).getLastMessage();
    return true;
  }

  sendRequest(dynamic data, WidgetRef ref) async {
    String senderDeviceId = data['senderDeviceId'];
    String messageId = data['messageId'];
    String? senderName = data['senderName'];
    String senderSocketId = data['senderSocketId'];
    String recipientDeviceId = (await PlatformDeviceId.getDeviceId)!;
    final conversationId = [senderDeviceId, recipientDeviceId];
    final sortConversationId = conversationId.toList();
    sortConversationId.sort();
    final message = MessageModel(
        dateTime: DateTime.now(),
        message: 'Accept Request?',
        senderDeviceId: senderDeviceId,
        recipientName: senderName,
        messageId: messageId,
        senderName: 'User $senderDeviceId',
        isRequest: true,
        senderSocketId: senderSocketId,
        recipientDeviceId: recipientDeviceId,
        conversationId: conversationId.join('-'),
        sortConversationId: conversationId.join('-'));
    await ref.read(lastMessageProvider.notifier).showRequest(message);
    return true;
  }

  sendAcceptedRequest(dynamic data, WidgetRef ref) async {
    String senderDeviceId = data['senderDeviceId'];
    String messageId = data['messageId'];
    String? senderName = data['senderName'];
    String senderSocketId = data['senderSocketId'];
    String recipientDeviceId = (await PlatformDeviceId.getDeviceId)!;
    final conversationId = [senderDeviceId, recipientDeviceId];
    final sortConversationId = conversationId.toList();
    sortConversationId.sort();
    final message = MessageModel(
      dateTime: DateTime.now(),
      message: 'Request Accepted!',
      senderSocketId: senderSocketId,
      conversationId: conversationId.join('-'),
      messageId: messageId,
      sortConversationId: conversationId.join('-'),
      recipientName: senderName,
      senderName: 'User $recipientDeviceId',
      senderDeviceId: recipientDeviceId,
      recipientDeviceId: senderDeviceId,
    );
    await ref.read(lastMessageProvider.notifier).showRequest(message);
    return true;
  }
}
