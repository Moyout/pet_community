import 'package:pet_community/util/tools.dart';
import 'package:pet_community/views/message/chat_view.dart';

class MessageView extends StatefulWidget {
  const MessageView({Key? key}) : super(key: key);

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  @override
  void initState() {
    // var channel = IOWebSocketChannel.connect("ws://localhost:8081/chat");
    //
    // channel.stream.listen((message) {
    //   channel.sink.add('received!');
    //   channel.sink.close(status.goingAway);
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            RouteUtil.pushByCupertino(context, ChatView());
          },
          child: Text("无信息"),
        ),
      ),
    );
  }
}
