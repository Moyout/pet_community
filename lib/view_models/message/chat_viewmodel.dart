import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:pet_community/models/chat/chat_record_model.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/util/websocket/websocket_util.dart';
import 'package:pet_community/view_models/message/chat_record_viewmodel.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';

class ChatViewModel extends ChangeNotifier {
  TextEditingController textC = TextEditingController();
  bool isVoice = false; //是否语音输入
  int numLines = 1; //文字行数
  bool currentEmoji = false; //表情库
  bool onLongPress = false;
  bool isPermission = false; //录音权限
  String? recordPath;
  FlutterSoundPlayer playerModule = FlutterSoundPlayer();

  FocusNode focusNode = FocusNode();
  ScrollController sc = ScrollController(); //滚动控制器
  ScrollController chatListC = ScrollController(); //滚动控制器

  ///初始化viewModel
  void initViewModel(BuildContext context) {
    currentEmoji = false;
    isVoice = false;
    onLongPress = false;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      textC.selection = TextSelection.fromPosition(
        TextPosition(offset: textC.text.length),
      );
      FocusScope.of(context).requestFocus(focusNode); // 获取焦点
    });
    playerModule.openPlayer();
  }

  ///语音文字切换
  Future<void> setIsVoice(BuildContext context) async {
    isVoice = !isVoice;
    await SystemChannels.textInput
        .invokeMethod(isVoice ? 'TextInput.hide' : 'TextInput.show')
        .then((v) => notifyListeners());
    if (isVoice) {
      focusNode.unfocus();
      currentEmoji = false;
    } else {
      // debugPrint("focusNode--------->${focusNode}");
      Future.delayed(const Duration(milliseconds: 200), () {
        FocusScope.of(context).requestFocus(focusNode);
      });
    }
    startPlay(context);
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
    if (currentEmoji) isVoice = false;
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

  ///长按状态
  Future<void> setOnLongPressState(bool state) async {
    isPermission = await Permission.microphone.request().isGranted;
    if (isPermission) onLongPress = state;
    notifyListeners();
  }

  Future<void> startPlay(BuildContext context) async {
    debugPrint("recordPath--------->${recordPath}");
    if (recordPath != null) {
      if (await File(recordPath!).exists()) {
        await playerModule.startPlayer(
          fromURI: recordPath,
          codec: Platform.isAndroid ? Codec.aacADTS : Codec.pcm16WAV,
          sampleRate: 44100,
          whenFinished: () {
            if (playerModule.isPlaying) playerModule.stopPlayer();
          },
        );
      }
    }
  }

  ///发送文本信息
  void sendTextMsg(BuildContext context, int receiverId) {
    if (AppUtils.getContext().read<NavViewModel>().netMode == ConnectivityResult.none) {
      ToastUtil.showBotToast(PublicKeys.netError, bgColor: PublicKeys.errorColor);
    } else {
      NavViewModel nvm = context.read<NavViewModel>();
      int sendTime = DateTime.now().millisecondsSinceEpoch;
      ChatRecordModel? crm = ChatRecordModel(
        code: 0,
        type: 0,
        userId: nvm.userInfoModel!.data!.userId,
        data: textC.text,
        sendTime: sendTime,
        receiverId: receiverId,
        otherId: receiverId,
      );
      debugPrint("crm--------->${crm}");

      String data = jsonEncode(crm);

      ///发送ws信息
      WebSocketUtils().send(data);

      ///存入数据库
      ChatRecordDB.insertData(nvm.userInfoModel!.data!.userId, crm, crm.receiverId);
      context.read<ChatRecordViewModel>().list.insert(0, crm);

      ///聊天列表进行排序
      context.read<NavViewModel>().sortChatList();

      ///添加到 聊天记录列表中
      if (crm.data != null) {
        if (nvm.contactList[receiverId] == null) {
          nvm.contactList.addAll({receiverId: []});
        }
        nvm.contactList[receiverId]?.add(crm);
      }
      debugPrint("nvm.contactList--------------》》${nvm.contactList}");
      nvm.notifyListeners();
      textC.clear();
      chatListC.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.ease);
      notifyListeners();
    }
  }

  Future<void> sendVoiceMsg(BuildContext context, int receiverId) async {
    if (AppUtils.getContext().read<NavViewModel>().netMode == ConnectivityResult.none) {
      ToastUtil.showBotToast(PublicKeys.netError, bgColor: PublicKeys.errorColor);
    } else {
      if (recordPath != null) {
        if (await File(recordPath!).exists()) {
          File file = File(recordPath!);

          NavViewModel nvm = context.read<NavViewModel>();
          int sendTime = DateTime.now().millisecondsSinceEpoch;
          ChatRecordModel? crm = ChatRecordModel(
            code: 0,
            type: 2,
            userId: nvm.userInfoModel!.data!.userId,
            data: [],
            //todo
            sendTime: sendTime,
            receiverId: receiverId,
            otherId: receiverId,
          );
          debugPrint("crm--------->${crm}");

          String data = jsonEncode(crm);

          ///发送ws信息
          WebSocketUtils().send(data);
        }
      }
    }
  }

  Future<String> fetchData() async {
    await Future.delayed(Duration(seconds: 2));
    return "我是Stream中的数据";
  }
}
