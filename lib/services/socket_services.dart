import 'package:chat/riverpod/provider.dart';

import '/utils/utils.dart';

class SocketServices {
  static final SocketServices instance = SocketServices._init();
  static Socket? _socket;
  SocketServices._init();

  Socket get socket {
    if (_socket != null) return _socket!;
    _socket = io('https://6dd8-2c0f-f5c0-433-82e1-c960-472d-e440-f363.ngrok.io',
        OptionBuilder().setTransports(['websocket']).build());
    return _socket!;
  }

  void connectAndListen(WidgetRef ref) {
    socket.onConnect((data) => debugPrint('Connected'));
    socket.onError((data) => debugPrint('Error => $data'));
    socket.onDisconnect((data) => debugPrint('Disconnected'));
    socket.on('message', (data) => receiveMessage(data, ref));
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
    await ref.read(lastMessageProvider.notifier).getLastMessage();
    return true;
  }
}
