import 'package:pet_community/enums/chat_record_enum.dart';
import 'package:pet_community/models/chat/chat_record_model.dart';
import 'package:pet_community/util/time_util.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/message/chat_record_viewmodel.dart';
import 'package:pet_community/view_models/message/chat_viewmodel.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatRecordView extends StatefulWidget {
  final int userId;
  final String? avatar;

  const ChatRecordView({Key? key, required this.userId, this.avatar}) : super(key: key);

  @override
  State<ChatRecordView> createState() => _ChatRecordViewState();
}

class _ChatRecordViewState extends State<ChatRecordView> {
  @override
  void initState() {
    super.initState();
    context.read<ChatRecordViewModel>().initViewModel(context, widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      controller: context.watch<ChatViewModel>().sc,
      thumbColor: Colors.blueGrey,
      child: SmartRefresher(
        controller: context.watch<ChatRecordViewModel>().refreshC,
        enablePullDown: false,
        enablePullUp: context.read<ChatRecordViewModel>().enablePullUp,
        reverse: true,
        onLoading: () => context.read<ChatRecordViewModel>().onLoad(context, widget.userId),
        child: Container(
          color: context.read<ChatViewModel>().onLongPress ? Colors.grey : null,
          alignment: context.watch<ChatRecordViewModel>().list.length < 10 ? Alignment.topCenter : null, //需判断是否能滑动
          child: ListView.separated(
            reverse: true,
            shrinkWrap: true,
            controller: context.watch<ChatViewModel>().chatListC,
            itemCount: context.watch<ChatRecordViewModel>().list.length + 1,
            itemBuilder: (context, index) {
              return index == context.read<ChatRecordViewModel>().list.length
                  ? const SizedBox()
                  : Container(
                      // alignment: Alignment.topCenter,
                      // color: Colors.red,
                      margin: EdgeInsets.only(bottom: 20.w),
                      child: Row(
                        mainAxisAlignment: context.watch<ChatRecordViewModel>().list[index].userId !=
                                context.read<NavViewModel>().userInfoModel?.data?.userId
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          context.watch<ChatRecordViewModel>().list[index].userId !=
                                  context.read<NavViewModel>().userInfoModel?.data?.userId
                              ? Container(
                                  clipBehavior: Clip.antiAlias,
                                  margin: EdgeInsets.only(right: 5.w, left: 5.w),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.w)),
                                  child: widget.avatar != null
                                      ? CachedNetworkImage(
                                          imageUrl: widget.avatar!,
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
                          context.watch<ChatRecordViewModel>().list[index].userId !=
                                  context.read<NavViewModel>().userInfoModel?.data?.userId
                              ? Container(
                                  width: 5.w,
                                  height: 0,
                                  margin: EdgeInsets.only(top: 18.w),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:
                                          BorderSide(color: Colors.transparent, width: 8.w, style: BorderStyle.solid),
                                      left: BorderSide(
                                        color: Theme.of(context).brightness == Brightness.light
                                            ? Colors.white
                                            : Colors.white10,
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
                              color: context.watch<ChatRecordViewModel>().list[index].userId ==
                                      context.read<NavViewModel>().userInfoModel?.data?.userId
                                  ? Colors.green
                                  : Theme.of(context).brightness == Brightness.light
                                      ? Colors.white
                                      : Colors.white10,
                              borderRadius: BorderRadius.circular(4.w),
                            ),
                            child: context.watch<ChatRecordViewModel>().list[index].type == ChatRecordEnum.voice.number
                                ? const Icon(Icons.multitrack_audio)
                                : Text("${context.watch<ChatRecordViewModel>().list[index].data}"),
                          ),
                          context.watch<ChatRecordViewModel>().list[index].userId ==
                                  context.read<NavViewModel>().userInfoModel?.data?.userId
                              ? Container(
                                  width: 5.w,
                                  height: 0,
                                  margin: EdgeInsets.only(top: 18.w),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:
                                          BorderSide(color: Colors.transparent, width: 8.w, style: BorderStyle.solid),
                                      right: BorderSide(color: Colors.green, width: 8.w, style: BorderStyle.solid),
                                      top: BorderSide(color: Colors.transparent, width: 8.w, style: BorderStyle.solid),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          (context.watch<ChatRecordViewModel>().list[index].userId ==
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
            separatorBuilder: (BuildContext context, int index) {
              List<ChatRecordModel> list = context.watch<ChatRecordViewModel>().list;
              String? time;
              if (list[index].showTime) {
                time = TimeUtils.timeDifferenceCurrTime(list[index].sendTime);
              }

              return time != null
                  ? Center(
                      child: Text(time),
                    )
                  : SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
