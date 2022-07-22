import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/message/chat_viewmodel.dart';

class EmojiView extends StatefulWidget {
  const EmojiView({Key? key}) : super(key: key);

  @override
  State<EmojiView> createState() => _EmojiViewState();
}

class _EmojiViewState extends State<EmojiView> {
  List emojiList = [
    "\u{1f600}",
    "\u{1f601}",
    "\u{1f602}",
    "\u{1f606}",
    "\u{1f610}",
    "\u{1f612}",
    "\u{1f614}",
    "\u{1f615}",
    "\u{1f617}",
    "\u{1f623}",
    "\u{1f624}",
    "\u{1f626}",
    "\u{1f631}",
    "\u{1f632}",
    "\u{1f633}",
    "\u{1f634}",
    "\u{1f635}",
    "\u{1f636}",
    "\u{1f637}",
    "\u{1f641}",
    "\u{1f642}",
    "\u{1f643}",
    "\u{1f644}",
    "\u{1f648}",
    "\u{1f601}",
    "\u{1f602}",
    "\u{1f606}",
    "\u{1f610}",
    "\u{1f612}",
    "\u{1f614}",
    "\u{1f615}",
    "\u{1f617}",
    "\u{1f623}",
    "\u{1f624}",
    "\u{1f626}",
    "\u{1f631}",
    "\u{1f632}",
    "\u{1f633}",
    "\u{1f634}",
    "\u{1f635}",
    "\u{1f636}",
    "\u{1f637}",
    "\u{1f641}",
    "\u{1f642}",
    "\u{1f643}",
    "\u{1f644}",
    "\u{1f648}",
    "\u{1f601}",
    "\u{1f602}",
    "\u{1f606}",
    "\u{1f610}",
    "\u{1f612}",
    "\u{1f614}",
    "\u{1f615}",
    "\u{1f617}",
    "\u{1f623}",
    "\u{1f624}",
    "\u{1f626}",
    "\u{1f631}",
    "\u{1f632}",
    "\u{1f633}",
    "\u{1f634}",
    "\u{1f635}",
    "\u{1f636}",
    "\u{1f637}",
    "\u{1f641}",
    "\u{1f642}",
    "\u{1f643}",
    "\u{1f644}",
    "\u{1f648}",
  ];

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {},
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: const BoxDecoration(color: Colors.white),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5.w),
            height: context.watch<ChatViewModel>().currentEmoji ? 250.w : 0,
            child: DefaultTextStyle(
              style: TextStyle(fontSize: 23.sp),
              child: Stack(
                children: [
                  GridView.builder(
                    itemCount: emojiList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8,
                      crossAxisSpacing: 5.w,
                      mainAxisSpacing: 5.w,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => context.read<ChatViewModel>().insertEmoji(context, emojiList[index]),
                        child: Container(
                          alignment: Alignment.center,
                          // color: Colors.primaries[index.clamp(0, 17)],
                          child: Text(emojiList[index]),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 10.w,
                    right: 10.w,
                    child: GestureDetector(
                      onTap: () => context.read<ChatViewModel>().backspace(),
                      child: Icon(Icons.backspace, size: 23.w, color: ThemeUtil.reversePrimaryColor(context)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
