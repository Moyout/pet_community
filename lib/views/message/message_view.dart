import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/view_models/startup_viewmodel.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessageView extends StatefulWidget {
  const MessageView({Key? key}) : super(key: key);

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  ScrollController sc = ScrollController();
  final fifteenAgo = DateTime.now().subtract(Duration(minutes: 15));

  @override
  void initState() {
    // var channel = IOWebSocketChannel.connect("ws://localhost:8081/chat");
    //
    // channel.stream.listen((message) {
    //   channel.sink.add('received!');
    //   channel.sink.close(status.goingAway);
    // });

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
                    var date = DateTime.fromMillisecondsSinceEpoch(e.value.last.sendTime! * 1000);

                    return TextButton(
                      onPressed: () {},
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
                                e.value.last.userName ?? "",
                                style: TextStyle(fontSize: 16.sp, color: ThemeUtil.reversePrimaryColor(context)),
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
                          Text(timeago.format(date))
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
