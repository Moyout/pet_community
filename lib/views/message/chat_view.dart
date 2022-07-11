import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/message/chat_viewmodel.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios_new,
          color: ThemeUtil.reversePrimaryColor(context),
          size: 20.w,
        ),
        title: Text("xxx", style: TextStyle(fontSize: 18.sp)),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 400,
                    color: Colors.cyan,
                  ),
                  Container(
                    height: 200,
                    color: Colors.blue,
                  ),
                  Container(
                    height: 400,
                    color: Colors.cyan,
                  ),
                ],
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => context.read<ChatViewModel>().setIsVoice(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Icon(
                    context.read<ChatViewModel>().isVoice ? Icons.translate : Icons.settings_voice_outlined,
                    size: 20.w,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(6.w),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  margin: EdgeInsets.symmetric(vertical: 5.w),
                  child: TextField(
                    onChanged: (v) => context.read<ChatViewModel>().getTextLines(),
                    controller: context.watch<ChatViewModel>().textC,
                    scrollPadding: EdgeInsets.zero,
                    maxLines: context.watch<ChatViewModel>().numLines < 6 ? null : 6,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => context.read<ChatViewModel>().setIsVoice(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Icon(
                    context.read<ChatViewModel>().isVoice ? Icons.translate : Icons.settings_voice_outlined,
                    size: 20.w,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
