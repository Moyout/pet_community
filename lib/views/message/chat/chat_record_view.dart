import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/message/chat_viewmodel.dart';

class ChatRecordView extends StatefulWidget {
  const ChatRecordView({Key? key}) : super(key: key);

  @override
  State<ChatRecordView> createState() => _ChatRecordViewState();
}

class _ChatRecordViewState extends State<ChatRecordView> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: context.watch<ChatViewModel>().sc,
      child: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Container(
              // color: Colors.primaries[index % 10],
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                    child: Text("这是一条聊天内容$index"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
