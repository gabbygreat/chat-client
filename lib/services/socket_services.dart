import '/utils/utils.dart';

class SocketServices {
  static final SocketServices instance = SocketServices._init();
  static Socket? _socket;
  SocketServices._init();

  Socket get socket {
    if (_socket != null) return _socket!;
    _socket = io('https://fb6f-197-210-84-114.eu.ngrok.io',
        OptionBuilder().setTransports(['websocket']).build());
    return _socket!;
  }

  connectAndListen() {
    socket.onConnect((data) => debugPrint('Connected'));
    socket.onError((data) => debugPrint('Error => $data'));
    socket.onDisconnect((data) => debugPrint('Disconnected'));
    socket.on('test', (data) => debugPrint(data));
    socket.on('message', (data) => receiveMessage(data));
    sendMessage('Test Emit');
  }

  sendMessage(String message) {
    socket.emit('message', message);
  }

  receiveMessage(dynamic data) {
    debugPrint(data);
  }
}
