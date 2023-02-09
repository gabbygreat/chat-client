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
    socket.on('message', (data) async => await receiveMessage(data, ref));
    socket.on('request', (data) async => await sendRequest(data, ref));
    socket.on('accept', (data) async => await sendAcceptedRequest(data, ref));
  }

  void sendMessage(MessageModel message) {
    socket.emit(
      'message',
      message.toMap(),
    );
  }

  Future<bool> receiveMessage(dynamic data, WidgetRef ref) async {
    MessageModel messageModel = MessageModel.fromMap(data);
    messageModel.type = 'recieve';
    await LocalChatHistory.instance.updateLocal(message: messageModel);
    await ref.read(messageProvider.notifier).getMessages(messageModel);
    await ref.read(lastMessageProvider.notifier).getLastMessage();
    return true;
  }

  Future<bool> sendRequest(dynamic data, WidgetRef ref) async {
    String senderDeviceId = data['senderDeviceId'];
    String messageId = data['messageId'];
    String senderSocketId = data['senderSocketId'];
    String recipientDeviceId = (await PlatformDeviceId.getDeviceId)!;
    final conversationId = [senderDeviceId, recipientDeviceId];
    final sortConversationId = conversationId.toList();
    sortConversationId.sort();
    final message = MessageModel(
      dateTime: DateTime.now(),
      message: 'Accept Request?',
      messageId: messageId,
      isRequest: true,
      type: 'recieve',
      conversationId: conversationId.join('-'),
      sortConversationId: sortConversationId.join('-'),
      senderName: 'User $senderDeviceId',
      senderSocketId: senderSocketId,
      senderDeviceId: senderDeviceId,
      recipientName: 'User $recipientDeviceId',
      recipientDeviceId: recipientDeviceId,
      // recipientSocketId: senderSocketId, //to do
    );
    await ref.read(lastMessageProvider.notifier).showRequest(message);
    return true;
  }

  Future<bool> sendAcceptedRequest(dynamic data, WidgetRef ref) async {
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
      conversationId: conversationId.join('-'),
      messageId: messageId,
      type: 'recieve',
      sortConversationId: sortConversationId.join('-'),
      senderName: 'User $recipientDeviceId',
      senderSocketId: GlobalVariable.socketId,
      senderDeviceId: recipientDeviceId,
      recipientName: senderName,
      recipientDeviceId: senderDeviceId,
      recipientSocketId: senderSocketId,
    );
    await ref.read(lastMessageProvider.notifier).updateAcceptedRequest(message);
    return true;
  }
}
