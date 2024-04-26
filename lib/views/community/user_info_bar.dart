import 'package:flutter/cupertino.dart';
import 'package:pet_community/models/user/user_info_model.dart';
import 'package:pet_community/util/tools.dart';

class UserInfoBar extends StatefulWidget {
  final int? userId;
  final String publicationTime;

  const UserInfoBar({
    Key? key,
    required this.userId,
    required this.publicationTime,
  }) : super(key: key);

  @override
  State<UserInfoBar> createState() => _UserInfoBarState();
}

class _UserInfoBarState extends State<UserInfoBar> with AutomaticKeepAliveClientMixin {
  String? avatar;
  String? userName;

  @override
  void initState() {
    super.initState();
    getUserAvatar();
  }

  void getUserAvatar() async {
    UserInfoModel result = await UserInfoRequest.getOtherUserInfo(widget.userId, false);
    avatar = result.data?.avatar;
    userName = result.data?.userName;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Row(
      children: [
        ClipOval(
          child: avatar != null
              ? Image.network(
                  avatar!,
                  width: 45.w,
                  height: 45.w,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) => loadingProgress != null
                      ? const Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : child,
                )
              : Image.asset("assets/images/ic_launcher.png", width: 45.w, height: 45.w, fit: BoxFit.cover),
        ),
        SizedBox(width: 10.w),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // width: 250.w,
              constraints: BoxConstraints(maxWidth: 250.w),
              child: Text(
                userName ?? "",
                style: TextStyle(fontSize: 15.sp),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Text(
              widget.publicationTime,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive {
    return true;
  }
}
