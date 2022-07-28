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
          itemCount: 30,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start, //TODO: 位置
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.only(right: 5.w, left: 5.w),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.w)),
                    child: Image.asset(
                      "assets/images/backgrounds/likes_background.png",
                      width: 30.w,
                      height: 30.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: 8.w,
                    height: 0,
                    margin: EdgeInsets.only(top: 15.w),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.transparent, width: 8.w, style: BorderStyle.solid),
                        left: BorderSide(
                          color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.white10,
                          width: 8.w,
                          style: BorderStyle.solid,
                        ),
                        top: BorderSide(color: Colors.transparent, width: 8.w, style: BorderStyle.solid),
                      ),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.w),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.white10,
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                    child: Text("这是一条聊天这是一这是一条聊天这是一  $index"),
                  ),
                  Container(
                    width: 8.w,
                    height: 0,
                    margin: EdgeInsets.only(top: 15.w),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.transparent, width: 8.w, style: BorderStyle.solid),
                        right: BorderSide(color: Colors.green, width: 8.w, style: BorderStyle.solid),
                        top: BorderSide(color: Colors.transparent, width: 8.w, style: BorderStyle.solid),
                      ),
                    ),
                  ),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.only(right: 5.w, left: 5.w),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.w)),
                    child: Image.asset(
                      "assets/images/backgrounds/likes_background.png",
                      width: 30.w,
                      height: 30.w,
                      fit: BoxFit.cover,
                    ),
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
