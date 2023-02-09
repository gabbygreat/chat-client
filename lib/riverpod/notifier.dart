import '../utils/utils.dart';

class MessageNotifierProvider extends StateNotifier<List<MessageModel>> {
  MessageNotifierProvider(super.state);

  Future<void> addMessage(
    MessageModel message, {
    bool sendMessage = true,
    bool createLocal = true,
  }) async {
    final oldMessage =
        await LocalChatHistory.instance.readLocalConversation(message);
    state = [...oldMessage, message];
    if (sendMessage) {
      SocketServices.instance.sendMessage(message);
    }
    if (createLocal) {
      await LocalChatHistory.instance.create([message]);
    }
  }

  Future<void> getMessages(MessageModel messageInfo) async {
    state = await LocalChatHistory.instance.readLocalConversation(messageInfo);
  }
}

class LastMessageNotifierProvider extends StateNotifier<List<MessageModel>> {
  LastMessageNotifierProvider(super.state);

  Future<void> getLastMessage() async {
    state = await LocalChatHistory.instance.getLastMessageList();
  }

  showRequest(MessageModel model) {
    state = [...state, model];
    state.where((element) => element.isRequest == false).toList();
    state.sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  updateAcceptedRequest(MessageModel model) {
    state = state.where((element) => element != model).toList();
    state = state.where((element) => element.isRequest == false).toList();
    final message = MessageModel(
      dateTime: DateTime.now(),
      message: 'Request Accepted!',
      senderSocketId: model.senderSocketId,
      conversationId: model.conversationId,
      messageId: model.messageId,
      type: 'send',
      sortConversationId: model.sortConversationId,
      recipientName: model.recipientName,
      senderName: model.senderName,
      senderDeviceId: model.senderDeviceId,
      recipientDeviceId: model.recipientDeviceId,
    );
    state = [...state, message];
    state.sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }
}
