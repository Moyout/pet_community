import 'package:pet_community/models/user/user_info_model.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/message/chat_viewmodel.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/view_models/startup_viewmodel.dart';

class ChatRecordView extends StatefulWidget {
  final int userId;

  const ChatRecordView({Key? key, required this.userId}) : super(key: key);

  @override
  State<ChatRecordView> createState() => _ChatRecordViewState();
}

class _ChatRecordViewState extends State<ChatRecordView> {
  UserInfoModel? userInfoModel;

  void getUserAvatar() async {
    debugPrint("widget.userId--------->${widget.userId}");
    userInfoModel = await UserInfoRequest.getOtherUserInfo(widget.userId, false);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getUserAvatar();
  }

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      controller: context.watch<ChatViewModel>().sc,
      child: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: ListView.builder(
          controller: context.watch<ChatViewModel>().chatListC,
          itemCount: context.watch<NavViewModel>().contactList[widget.userId]?.length ?? 0,
          itemBuilder: (context, index) {
            return Container(
              // color: Colors.red,
              margin: EdgeInsets.only(bottom: 20.w),
              child: Row(
                mainAxisAlignment: context.read<NavViewModel>().contactList[widget.userId]?[index].userId !=
                        context.read<NavViewModel>().userInfoModel?.data?.userId
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  context.read<NavViewModel>().contactList[widget.userId]?[index].userId !=
                          context.read<NavViewModel>().userInfoModel?.data?.userId
                      ? Container(
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.only(right: 5.w, left: 5.w),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.w)),
                          child: userInfoModel?.data?.avatar != null
                              ? CachedNetworkImage(
                                  imageUrl: userInfoModel!.data!.avatar!,
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
                        )
                      : const SizedBox(),
                  context.read<NavViewModel>().contactList[widget.userId]?[index].userId !=
                          context.read<NavViewModel>().userInfoModel?.data?.userId
                      ? Container(
                          width: 5.w,
                          height: 0,
                          margin: EdgeInsets.only(top: 18.w),
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
                        )
                      : const SizedBox(),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.w),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.w),
                    decoration: BoxDecoration(
                      color: context.read<NavViewModel>().contactList[widget.userId]?[index].userId ==
                              context.read<NavViewModel>().userInfoModel?.data?.userId
                          ? Colors.green
                          : Theme.of(context).brightness == Brightness.light
                              ? Colors.white
                              : Colors.white10,
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                    child: Text("${context.read<NavViewModel>().contactList[widget.userId]?[index].data}"),
                  ),
                  context.read<NavViewModel>().contactList[widget.userId]?[index].userId ==
                          context.read<NavViewModel>().userInfoModel?.data?.userId
                      ? Container(
                          width: 5.w,
                          height: 0,
                          margin: EdgeInsets.only(top: 18.w),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.transparent, width: 8.w, style: BorderStyle.solid),
                              right: BorderSide(color: Colors.green, width: 8.w, style: BorderStyle.solid),
                              top: BorderSide(color: Colors.transparent, width: 8.w, style: BorderStyle.solid),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  (context.read<NavViewModel>().contactList[widget.userId]?[index].userId ==
                          context.read<NavViewModel>().userInfoModel?.data?.userId)
                      ? Container(
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.only(right: 5.w, left: 5.w),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.w)),
                          child: context.watch<NavViewModel>().userInfoModel?.data?.avatar != null
                              ? CachedNetworkImage(
                                  imageUrl: context.watch<NavViewModel>().userInfoModel?.data?.avatar ?? "",
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
                        )
                      : const SizedBox(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
