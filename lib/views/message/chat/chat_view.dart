import 'package:pet_community/config/notification_config.dart';
import 'package:pet_community/models/chat/chat_record_model.dart';
import 'package:pet_community/models/user/user_info_model.dart';
import 'package:pet_community/util/database/chat_record_db.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/message/chat_viewmodel.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/views/message/chat/chat_record_view.dart';
import 'package:pet_community/views/message/chat/emoji_view.dart';
import 'package:pet_community/widget/audio/recorded_audio_widget.dart';

class ChatView extends StatefulWidget {
  static const String routeName = 'ChatView';

  final int userId;

  const ChatView({Key? key, required this.userId}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> with AutomaticKeepAliveClientMixin {
  UserInfoModel? userInfoModel;

  @override
  void initState() {
    super.initState();
    NotificationConfig.closeNotification(widget.userId);
    context.read<ChatViewModel>().initViewModel(context);
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    userInfoModel = await UserInfoRequest.getOtherUserInfo(widget.userId, false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => RouteUtil.pop(context),
            child: Icon(Icons.arrow_back_ios_new, color: ThemeUtil.reversePrimaryColor(context), size: 20.w),
          ),
          title: Text(userInfoModel?.data?.userName ?? "", style: TextStyle(fontSize: 14.sp)),
        ),
        body: GestureDetector(
          onTap: () {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
          child: Container(
            color: ThemeUtil.scaffoldColor(context),
            padding: EdgeInsets.only(bottom: 6.w),
            child: Column(
              children: [
                Expanded(
                  child: ChatRecordView(userId: widget.userId, avatar: userInfoModel?.data?.avatar),
                ),
                Container(
                  color: Colors.grey,
                  child: Visibility(
                    visible: context.read<ChatViewModel>().onLongPress,
                    child: const RecordAudioWidget(),
                  ),
                ),
                Column(
                  children: [
                    Divider(
                      thickness: 1.w,
                      height: 0,
                      color: ThemeUtil.reversePrimaryColor(context).withOpacity(0.5),
                    ),
                    Container(
                      color: ThemeUtil.scaffoldColor(context),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => context.read<ChatViewModel>().setIsVoice(context),
                            child: Container(
                              padding: EdgeInsets.all(10.w),
                              child: Icon(
                                context.watch<ChatViewModel>().isVoice
                                    ? Icons.translate
                                    : Icons.settings_voice_outlined,
                                size: 20.w,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: !context.watch<ChatViewModel>().isVoice,
                            // maintainState: true,
                            replacement: Expanded(
                              child: GestureDetector(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: context.read<ChatViewModel>().onLongPress
                                        ? Colors.blue.withOpacity(0.5)
                                        : Colors.grey.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(4.w),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.w),
                                  margin: EdgeInsets.symmetric(vertical: 5.w),
                                  child: Text(
                                    context.read<ChatViewModel>().onLongPress ? "松开发送" : "按住 说话",
                                  ),
                                ),
                                // onLongPress: () {
                                //   context.read<ChatViewModel>().setOnLongPressState(true);
                                //   debugPrint("长按中---------> {长按中}");
                                // },
                                onLongPressDown: (d) {
                                  context.read<ChatViewModel>().setOnLongPressState(true);
                                  debugPrint("d--------->${d}");
                                },
                                onLongPressUp: () {
                                  context.read<ChatViewModel>().setOnLongPressState(false);
                                  debugPrint("长按结束---------> {长按结束}");
                                },
                                onLongPressCancel: () {
                                  context.read<ChatViewModel>().setOnLongPressState(false);

                                  debugPrint("onLongPressCancel---------> {onLongPressCancel}");
                                },
                              ),
                            ),
                            // maintainState: true,
                            child: Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(4.w),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                margin: EdgeInsets.symmetric(vertical: 5.w),
                                child: RawScrollbar(
                                  controller: context.watch<ChatViewModel>().sc,
                                  thumbVisibility: true,
                                  child: TextField(
                                    scrollController: context.watch<ChatViewModel>().sc,
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
                                  onTap: () {
                                    debugPrint("发送语音测试---------> {发送语音测试}");
                                    context.read<ChatViewModel>().sendVoiceMsg(context, widget.userId );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(right: 10.w, top: 10.w, bottom: 10.w),
                                    child: Icon(Icons.add_circle_outline, size: 20.w),
                                  ),
                                )
                              : const SizedBox(),
                          AnimatedContainer(
                            alignment: Alignment.center,
                            duration: const Duration(milliseconds: 100),
                            margin: EdgeInsets.only(
                              right: context.watch<ChatViewModel>().textC.text.trim().isNotEmpty ? 5.w : 0,
                              bottom: 5.w,
                            ),
                            height: 30.w,
                            width: context.watch<ChatViewModel>().textC.text.trim().isNotEmpty ? 50.w : 0,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor: Colors.deepPurple,
                                padding: const EdgeInsets.all(0),
                              ),
                              onPressed: () => context.read<ChatViewModel>().sendTextMsg(context, widget.userId),
                              child: Text(
                                "发送",
                                style: TextStyle(color: ThemeUtil.primaryColor(context), fontSize: 10.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (MediaQuery.of(context).viewInsets.bottom == 0) const EmojiView(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
