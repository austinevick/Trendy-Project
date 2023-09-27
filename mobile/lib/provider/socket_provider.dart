import 'package:socket_io_client/socket_io_client.dart';

class SocketProvider {
  late Socket socket;

  init() {
    try {
      socket = io('http://127.0.0.1:3000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

      socket.connect();

      socket.on('connect', (_) => print('connect: ${socket.id}'));
      socket.on('likes', (_) => handleLikes());
    } catch (e) {
      print(e.toString());
    }
  }

  void handleLikes() {
    socket.emit('likes', 'Hello dear');
  }
}
