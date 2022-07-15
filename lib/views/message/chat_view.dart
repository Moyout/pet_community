import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/message/chat_viewmodel.dart';
import 'package:pet_community/views/message/chat/emoji_view.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  ScrollController sc = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ChatViewModel>().initViewModel(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => RouteUtil.pop(context),
          child: Icon(Icons.arrow_back_ios_new, color: ThemeUtil.reversePrimaryColor(context), size: 20.w),
        ),
        title: Text("xxx", style: TextStyle(fontSize: 18.sp)),
      ),
      body: GestureDetector(
        onTap: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        },
        child: Column(
          children: [
            Expanded(
              child: Scrollbar(
                // controller: sc,
                child: ScrollConfiguration(
                  behavior: OverScrollBehavior(),
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
                        Container(
                          height: 200,
                          color: Colors.blue,
                        ),
                        Container(
                          height: 400,
                          color: Colors.cyan,
                        ),
                        Container(
                          height: 200,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => context.read<ChatViewModel>().setIsVoice(),
                  child: Container(
                    padding: EdgeInsets.all(10.w),
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
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    margin: EdgeInsets.symmetric(vertical: 5.w),
                    child: RawScrollbar(
                      controller: sc,
                      isAlwaysShown: true,
                      child: TextField(
                        focusNode: context.watch<ChatViewModel>().focusNode,
                        onTap: () {
                          context.read<ChatViewModel>().currentEmoji = false;
                          context.read<ChatViewModel>().notifyListeners();
                        },
                        onChanged: (v) => context.read<ChatViewModel>().getTextLines(),
                        controller: context.watch<ChatViewModel>().textC,
                        scrollPadding: EdgeInsets.zero,
                        maxLines: 5,
                        minLines: 1,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 16.sp, letterSpacing: 1),
                        decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 6.w),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => context.read<ChatViewModel>().showEmoji(context),
                  child: Container(
                    padding: EdgeInsets.all(10.w),
                    child: Icon(
                      context.watch<ChatViewModel>().currentEmoji
                          ? Icons.keyboard_alt_outlined
                          : Icons.emoji_emotions_outlined,
                      size: 20.w,
                    ),
                  ),
                ),
                context.watch<ChatViewModel>().textC.text.isEmpty
                    ? GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(right: 10.w, top: 10.w, bottom: 10.w),
                          child: Icon(Icons.add_circle_outline, size: 20.w),
                        ),
                      )
                    : const SizedBox(),
                AnimatedContainer(
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 100),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                  margin: EdgeInsets.only(
                    right: context.watch<ChatViewModel>().textC.text.isNotEmpty ? 5.w : 0,
                    bottom: 5.w,
                  ),
                  height: 30.w,
                  width: context.watch<ChatViewModel>().textC.text.isNotEmpty ? 50.w : 0,
                  child: const Text("发送"),
                ),
              ],
            ),
            if (MediaQuery.of(context).viewInsets.bottom == 0) const EmojiView(),
            // ScrollConfiguration(
            //   behavior: OverScrollBehavior(),
            //   child: SingleChildScrollView(
            //     child: GestureDetector(
            //       onTap: () {},
            //       child: AnimatedContainer(
            //         duration: const Duration(milliseconds: 200),
            //         decoration: const BoxDecoration(color: Colors.white),
            //         padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5.w),
            //         height: context.watch<ChatViewModel>().currentEmoji && MediaQuery.of(context).viewInsets.bottom == 0
            //             ? 250.w
            //             : 0,
            //         child: DefaultTextStyle(
            //           style: TextStyle(fontSize: 23.sp),
            //           child: Stack(
            //             children: [
            //               GridView.builder(
            //                 itemCount: emojiList.length,
            //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //                   crossAxisCount: 8,
            //                   crossAxisSpacing: 5.w,
            //                   mainAxisSpacing: 5.w,
            //                   childAspectRatio: 1,
            //                 ),
            //                 itemBuilder: (context, index) {
            //                   return GestureDetector(
            //                     onTap: () => context.read<ChatViewModel>().insertEmoji(context, emojiList[index]),
            //                     child: Container(
            //                       alignment: Alignment.center,
            //                       // color: Colors.primaries[index.clamp(0, 17)],
            //                       child: Text(emojiList[index]),
            //                     ),
            //                   );
            //                 },
            //               ),
            //               Positioned(
            //                 bottom: 10.w,
            //                 right: 10.w,
            //                 child: GestureDetector(
            //                   onTap: () => context.read<ChatViewModel>().backspace(),
            //                   child: Icon(Icons.backspace, size: 23.w, color: ThemeUtil.reversePrimaryColor(context)),
            //                 ),
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
