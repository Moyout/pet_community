import 'dart:io';

import 'package:pet_community/util/tools.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  TextEditingController textC = TextEditingController();
  late WebSocket? webSocket;

  @override
  void initState() {
    webSocket2();
    super.initState();
  }

  Future<void> webSocket2() async {
    String? token = SpUtil.getString(PublicKeys.token);

    webSocket = await WebSocket.connect(
      "ws://10.0.2.2:8081/chat",
      headers: {
        "Origin": "*",
        "token": token,
      },
    );
    //监听函数
    webSocket?.listen(
      (v) {
        debugPrint("v--------->${v}");
      },
      onDone: () {
        print('连接关闭时响应');
        webSocket = null;
      },
      onError: (error) {
        print('发生错误');
      },
      cancelOnError: false,
    );
    webSocket?.add("客户端发送过去的");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("\u{1f44f} 无信息"),
            TextField(controller: textC),
            TextButton(
              onPressed: () {
                if (webSocket == null) {
                  webSocket2().then((value) {
                    webSocket?.add(textC.text + "\u{1f44f}");
                  });
                }
              },
              child: Text("提交"),
            )
          ],
        ),
      ),
    );
  }
}
