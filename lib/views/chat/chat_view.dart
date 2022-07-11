import 'package:pet_community/util/tools.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  void initState() {
    // var channel = IOWebSocketChannel.connect("ws://localhost:8081/chat");
    // "ws://10.0.2.2:8081/chat",
    // channel.stream.listen((message) {
    //   channel.sink.add('received!');
    //   channel.sink.close(status.goingAway);
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("无信息"),
      ),
    );
  }
}
