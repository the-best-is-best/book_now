import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ListenSocket {
  static late WebSocketChannel channel;
  static init() {
    channel = IOWebSocketChannel.connect(
      Uri.parse('ws://192.168.1.2:8080/book_now/socket.php'),
    );
  }

  static lisen(String lisen) {
    channel.sink.add(lisen);
  }

  static close() {
    channel.sink.close();
  }
}
