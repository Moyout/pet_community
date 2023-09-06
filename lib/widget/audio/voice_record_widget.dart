import 'dart:convert';

import 'package:pet_community/models/chat/chat_record_model.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';

class VoiceRecordWidget extends StatefulWidget {
  final ChatRecordModel crm;

  const VoiceRecordWidget({super.key, required this.crm});

  @override
  State<VoiceRecordWidget> createState() => _VoiceRecordWidgetState();
}

class _VoiceRecordWidgetState extends State<VoiceRecordWidget> {
  late Map dataMap;
  bool playStatus = false;

  @override
  void initState() {
    super.initState();
    debugPrint("widget--------->${widget.crm}");
    dataMap = jsonDecode(widget.crm.data);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        playStatus = !playStatus;
        setState(() {});
      },
      child: Container(
        // width: 60.w,
        // padding: EdgeInsets.only(left: 20.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 20.w,
              height: 20.w,
              margin: EdgeInsets.only(right: 5.w),
              // color: Colors.teal,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: SizedBox(
                      width: 10.w,
                      height: 10.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.w,
                        value: 0.5,
                        color: ThemeUtil.brightness(context) == Brightness.dark
                            ? Colors.white
                            : widget.crm.userId == context.read<NavViewModel>().userInfoModel?.data?.userId
                                ? Colors.white
                                : Colors.black,
                        backgroundColor: Colors.grey,
                        // valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    // top: 0,
                    child: Icon(
                      playStatus ? Icons.pause_outlined : Icons.play_arrow_outlined,
                      size: 12.w,
                      color: ThemeUtil.brightness(context) == Brightness.dark
                          ? Colors.white
                          : widget.crm.userId == context.read<NavViewModel>().userInfoModel?.data?.userId
                              ? Colors.white
                              : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "${dataMap["duration"]}''",
              style: TextStyle(
                fontSize: 10.sp,
                color: ThemeUtil.brightness(context) == Brightness.dark
                    ? Colors.white
                    : widget.crm.userId == context.read<NavViewModel>().userInfoModel?.data?.userId
                        ? Colors.white
                        : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
