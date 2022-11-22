import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/home/video_detail_viewmodel.dart';

class InputCommentWidget extends StatefulWidget {
  const InputCommentWidget({Key? key}) : super(key: key);

  @override
  State<InputCommentWidget> createState() => _InputCommentWidgetState();
}

class _InputCommentWidgetState extends State<InputCommentWidget> {
  @override
  void initState() {
    super.initState();
    context.read<VideoDetailViewModel>().getFocusNode(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: ThemeUtil.primaryColor(context),
          // color: Colors.green,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  margin: EdgeInsets.symmetric(vertical: 5.w),
                  child: TextField(
                    focusNode: context.watch<VideoDetailViewModel>().focusNode,
                    controller: context.read<VideoDetailViewModel>().textC,
                    onTap: () {},
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
              SizedBox(
                height: 30.w,
                width: 50.w,
                child: TextButton(
                  onPressed: () {
                    ToastUtil.showBottomToast("该作品评论功能未开启");
                  },
                  child: Text("发表", style: TextStyle(color: Colors.white, fontSize: 10.sp)),
                  style: TextButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.all(0),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(height: MediaQuery.of(context).viewInsets.bottom)
      ],
    );
  }
}
