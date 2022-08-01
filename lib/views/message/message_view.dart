import 'package:intl/intl.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/view_models/startup_viewmodel.dart';
import 'package:pet_community/views/message/chat/chat_view.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timeago/timeago.dart';

class MessageView extends StatefulWidget {
  const MessageView({Key? key}) : super(key: key);

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  ScrollController sc = ScrollController();

  @override
  void initState() {
    // var channel = IOWebSocketChannel.connect("ws://localhost:8081/chat");
    //
    // channel.stream.listen((message) {
    //   channel.sink.add('received!');
    //   channel.sink.close(status.goingAway);
    // });
    // timeago.setDefaultLocale("zh_cn");
    timeago.setLocaleMessages("zh_CN", ZhCnMessages());
    super.initState();
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
                    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(e.value.last.sendTime ?? 0);
                    String dateTimeStr = DateFormat("HH:mm").format(dateTime);
                    return TextButton(
                      onPressed: () {
                        debugPrint("e--------------》》${e.value.first.userId}");
                        RouteUtil.pushByCupertino(
                          context,
                          ChatView(
                            userId: e.value.last.userId != context.read<NavViewModel>().userInfoModel?.data?.userId
                                ? e.value.last.userId!
                                : e.value.last.addresseeId!,
                            name: e.value.last.userId != context.read<NavViewModel>().userInfoModel?.data?.userId
                                ? e.value.last.userName ?? ""
                                : e.value.last.addressee ?? "",
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            margin: EdgeInsets.only(right: 5.w, left: 5.w),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.w)),
                            child: CachedNetworkImage(
                              imageUrl: e.value[0].userAvatar ??
                                  ApiConfig.baseUrl + "/images/pet${context.read<StartUpViewModel>().random}.jpg",
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
                                e.value.last.userId != context.read<NavViewModel>().userInfoModel?.data?.userId
                                    ? e.value.last.userName ?? ""
                                    : e.value.last.addressee ?? "",
                                style: TextStyle(fontSize: 14.sp, color: ThemeUtil.reversePrimaryColor(context)),
                              ),
                              Text(
                                e.value.last.data ?? "",
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
