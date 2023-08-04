import 'dart:convert';

import 'package:pet_community/models/chat/chat_record_model.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';

class ChatViewModel extends ChangeNotifier {
  TextEditingController textC = TextEditingController();
  bool isVoice = false; //是否语音输入
  int numLines = 1; //文字行数
  bool currentEmoji = false; //表情库
  FocusNode focusNode = FocusNode();
  ScrollController sc = ScrollController(); //滚动控制器
  ScrollController chatListC = ScrollController(); //滚动控制器

  ///初始化viewModel
  void initViewModel(BuildContext context) {
    currentEmoji = false;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      textC.selection = TextSelection.fromPosition(
        TextPosition(offset: textC.text.length),
      );
      FocusScope.of(context).requestFocus(focusNode); // 获取焦点
    });
  }

  ///语音文字切换
  void setIsVoice() {
    isVoice = !isVoice;
    notifyListeners();
  }

  ///获取文字行数
  void getTextLines() {
    numLines = '\n'.allMatches(textC.text).length + 1;
    notifyListeners();
  }

  ///显示表情框
  Future<void> showEmoji(BuildContext context) async {
    currentEmoji = !currentEmoji;
    if (!currentEmoji) FocusScope.of(context).requestFocus(focusNode); // 获取焦点

    await SystemChannels.textInput
        .invokeMethod(currentEmoji ? 'TextInput.hide' : 'TextInput.show')
        .then((v) => notifyListeners());
    // notifyListeners();
  }

  ///插入表情
  void insertEmoji(BuildContext context, String emoji) {
    int endIndex = textC.selection.start;
    String surplus = textC.value.text.substring(endIndex);
    textC.text = textC.value.text.substring(0, endIndex) + emoji + surplus;
    textC.selection = TextSelection.fromPosition(
      TextPosition(offset: endIndex + emoji.length),
    );

    notifyListeners();
  }

  ///退格
  void backspace() {
    final text = textC.text;
    final textSelection = textC.selection;
    // final selectionLength = textSelection.end - textSelection.start;
    // There is a selection.
    // if (selectionLength > 0) {
    //   debugPrint("执行了--------------》》 {执行了}");
    //   final newText = text.replaceRange(
    //     textSelection.start,
    //     textSelection.end,
    //     '',
    //   );
    //   textC.text = newText;
    //   textC.selection = textSelection.copyWith(
    //     baseOffset: textSelection.start,
    //     extentOffset: textSelection.start,
    //   );
    //   return;
    // }
    // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    }
    // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(newStart, newEnd, '');
    textC.text = newText;
    textC.selection = textSelection.copyWith(baseOffset: newStart, extentOffset: newStart);
    notifyListeners();
  }

  bool _isUtf16Surrogate(int value) {
    return value & 0xF800 == 0xD800;
  }

  ///发送
  void sendMsg(BuildContext context, int userId, String addressee) {
    NavViewModel nvm = context.read<NavViewModel>();
    int sendTime = DateTime.now().millisecondsSinceEpoch;
    ChatRecordModel? crm = ChatRecordModel(
      code: 0,
      type: 0,
      userId: nvm.userInfoModel!.data!.userId,
      data: textC.text,
      sendTime: sendTime,
      receiverId: userId,
    );
    debugPrint("crm--------->${crm}");

    String data = jsonEncode(crm);
    nvm.wsChannel?.sink.add(data);
    // debugPrint("data--------->${data}");
    // if (crm.data != null) {
    //   if (nvm.contactList[userId] == null) {
    //     nvm.contactList.addAll({userId: []});
    //   }
    //   nvm.contactList[userId]?.add(crm);
    // }
    // debugPrint("nvm--------------》》${nvm.contactList}");
    // nvm.contactList[userId]?.add(crm);
    nvm.notifyListeners();
    textC.clear();
    chatListC.animateTo(chatListC.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
    notifyListeners();
  }
}
