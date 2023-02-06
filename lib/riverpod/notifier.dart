import '../utils/utils.dart';

class MessageNotifierProvider extends StateNotifier<List<MessageModel>> {
  MessageNotifierProvider(super.state);

  addMessage(MessageModel message) {
    state = [...state, message];
  }
}
