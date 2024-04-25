import 'package:flutter/cupertino.dart';
import 'package:pet_community/models/user/user_info_model.dart';
import 'package:pet_community/util/tools.dart';

class UserAvatarName extends StatefulWidget {
  final int index;
  final int userId;

  const UserAvatarName({Key? key, required this.index, required this.userId}) : super(key: key);

  @override
  State<UserAvatarName> createState() => _UserAvatarNameState();
}

class _UserAvatarNameState extends State<UserAvatarName> with AutomaticKeepAliveClientMixin {
  String? avatar;
  String? userName;

  @override
  void initState() {
    super.initState();
    getUserAvatar();
    // debugPrint("widget--------->${widget.userId}");
  }

  void getUserAvatar() async {
    UserInfoModel result = await UserInfoRequest.getOtherUserInfo(widget.userId, false);
    avatar = result.data?.avatar;
    userName = result.data?.userName;
    // debugPrint("avatar--------->${avatar}");
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Row(
      children: [
        Hero(
          tag: "userAvatar:${widget.index}",
          child: ClipOval(
            child: avatar != null
                ? Image.network(
                    avatar!,
                    // cacheKey: "userAvatar:${widget.userId}",
                    width: 20.w,
                    height: 20.w,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) => loadingProgress != null
                        ? const Center(
                            child: CupertinoActivityIndicator(),
                          )
                        : child,
                    // loadingBuilder: (context, url, downloadProgress) => const CupertinoActivityIndicator(),
                  )
                : Image.asset(
                    "assets/images/ic_launcher.png",
                    width: 20.w,
                    height: 20.w,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        if (userName != null)
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Text(
                "$userName",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: ThemeUtil.reversePrimaryColor(context).withOpacity(0.5),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  bool get wantKeepAlive {
    return true;
  }
}
