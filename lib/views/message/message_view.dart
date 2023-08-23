import 'package:intl/intl.dart';
import 'package:pet_community/enums/chat_record_enum.dart';
import 'package:pet_community/models/chat/chat_record_model.dart';
import 'package:pet_community/models/user/user_info_model.dart';
import 'package:pet_community/util/database/chat_record_db.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/view_models/startup_viewmodel.dart';
import 'package:pet_community/views/message/chat/chat_view.dart';

class MessageView extends StatefulWidget {
  const MessageView({Key? key}) : super(key: key);

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  ScrollController sc = ScrollController();

  // Map<int, List<ChatRecordModel>> contactList = {};
  List<ChatRecordModel> list = [];
  Map<int, UserInfoModel?> userIdAvatarMap = {};

  @override
  void initState() {
    super.initState();

    getDatabaseData();
    getUserInfo();
  }

  void getUserInfo() {
    context.read<NavViewModel>().contactList.forEach((key, value) async {
      UserInfoModel userInfoModel = await UserInfoRequest.getOtherUserInfo(key, false);
      userIdAvatarMap.addAll({key: userInfoModel});
      debugPrint("userIdAvatarMap--------->${userIdAvatarMap}");
    });
  }

  ///查询聊天列表分组查询
  Future<void> getDatabaseData() async {
    list = await ChatRecordDB.groupByQueryRecentOneRecord(context.read<NavViewModel>().userInfoModel?.data?.userId);
    debugPrint("list--------->${list}");
    list.forEach((element) {
      if (context.read<NavViewModel>().contactList[element.otherId] == null) {
        context.read<NavViewModel>().contactList.addAll({element.otherId: []});
      }
      context.read<NavViewModel>().contactList[element.otherId]?.add(element);
    });

    ///聊天列表进行排序
    context.read<NavViewModel>().sortChatList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            // RouteUtil.pushByCupertino(context, const ChatView());
          },
          child: Scrollbar(
            controller: sc,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...context.watch<NavViewModel>().contactList.entries.map((e) {
                    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(e.value.last.sendTime);
                    String dateTimeStr = DateFormat("HH:mm").format(dateTime);

                    return TextButton(
                      onPressed: () {
                        debugPrint("e--------------》》${e.value.first.userId}");
                        RouteUtil.pushNamed(context, ChatView.routeName, arguments: {"userId": e.key});
                      },
                      child: Row(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            margin: EdgeInsets.only(right: 5.w, left: 5.w),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.w)),
                            child: userIdAvatarMap[e.key]?.data?.avatar != null
                                ? CachedNetworkImage(
                                    imageUrl: userIdAvatarMap[e.key]!.data!.avatar!,
                                    width: 40.w,
                                    height: 40.w,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    "assets/images/ic_launcher.png",
                                    width: 40.w,
                                    height: 40.w,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          SizedBox(width: 5.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userIdAvatarMap[e.key]?.data?.userName != null
                                    ? "${userIdAvatarMap[e.key]?.data?.userName}"
                                    : e.key.toString(),
                                style: TextStyle(fontSize: 14.sp, color: ThemeUtil.reversePrimaryColor(context)),
                              ),
                              SizedBox(
                                width: 250.w,
                                child: e.value.last.type == ChatRecordEnum.voice.number
                                    ? const Text("[语音]")
                                    : Text(
                                        "${e.value.last.data}",
                                        maxLines: 2,
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 14.sp,
                                          color: ThemeUtil.reversePrimaryColor(context).withOpacity(0.5),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(dateTimeStr, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
                        ],
                      ),
                    );
                    // return ListTile(
                    //   onTap: () {},
                    //   leading: ,
                    //   title: Text(e.value.last.userName ?? ""),
                    //   subtitle: Text(e.value.last.data ?? ""),
                    // );
                  }).toList()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
