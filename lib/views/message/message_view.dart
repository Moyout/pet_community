import 'package:intl/intl.dart';
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
  Map<int, UserInfoModel?> userIdAvatarMap = {};

  @override
  void initState() {
    super.initState();
    getUserInfo();
    ChatRecordDB.groupByQueryRecentOneRecord(context.read<NavViewModel>().userInfoModel?.data?.userId);
  }

  getUserInfo() {
    debugPrint("context.read<NavViewModel>().contactList--------->${context.read<NavViewModel>().contactList}");
    context.read<NavViewModel>().contactList.forEach((key, value) async {
      UserInfoModel userInfoModel = await UserInfoRequest.getOtherUserInfo(key, false);
      userIdAvatarMap.addAll({key: userInfoModel});
      debugPrint("userIdAvatarMap--------->${userIdAvatarMap}");
    });
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
                        RouteUtil.pushByCupertino(
                          context,
                          ChatView(userId: e.key),
                        );
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
                              Text(
                                "${e.value.last.data}",
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: ThemeUtil.reversePrimaryColor(context).withOpacity(0.5),
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

            // Container(
            //   clipBehavior: Clip.antiAlias,
            //   margin: EdgeInsets.only(right: 5.w, left: 5.w),
            //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.w)),
            //   child: CachedNetworkImage(
            //     imageUrl: e.value[0].userAvatar ??
            //         ApiConfig.baseUrl + "/images/pet${context.read<StartUpViewModel>().random}.jpg",
            //     width: 30.w,
            //     height: 30.w,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            // Text(e.value[0].data!),
            // child: ListView.builder(
            //   itemCount: context.watch<NavViewModel>().contactList.length,
            //   itemBuilder: (context, index) {
            //     return Row(
            //       children: [
            //         // Container(
            //         //   clipBehavior: Clip.antiAlias,
            //         //   margin: EdgeInsets.only(right: 5.w, left: 5.w),
            //         //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.w)),
            //         //   child: CachedNetworkImage(
            //         //     imageUrl: context.read<NavViewModel>().contactList[widget.userId]?[index].userAvatar ??
            //         //         ApiConfig.baseUrl + "/images/pet${context.read<StartUpViewModel>().random}.jpg",
            //         //     width: 30.w,
            //         //     height: 30.w,
            //         //     fit: BoxFit.cover,
            //         //   ),
            //         // ),
            //         Text("${context.watch<NavViewModel>().contactList[index]?[0].data}"),
            //       ],
            //     );
            //   },
            // ),
          ),
        ),
      ),
    );
  }
}
