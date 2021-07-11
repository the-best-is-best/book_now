import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class LisenSocket {
  static late WebSocketChannel channel;
  static init() {
    channel = IOWebSocketChannel.connect(
      Uri.parse('ws://192.168.1.6/book_now/socket.php'),
    );
  }

  static lisen(String lisen) {
    print("my channel  $channel");
    return channel.sink.add(lisen);
  }

  static close() {
    channel.sink.close();
  }
}
