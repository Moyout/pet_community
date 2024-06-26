import 'package:flutter/rendering.dart';
import 'package:pet_community/models/article_comment/release_comment_model.dart';
import 'package:pet_community/models/video/video_detail_model.dart';
import 'package:pet_community/models/video_comment/video_comment_model.dart';
import 'package:pet_community/util/tools.dart';

class VideoDetailViewModel extends ChangeNotifier {
  TextEditingController textC = TextEditingController();
  ScrollController sc = ScrollController();
  bool showComment = false;
  FocusNode focusNode = FocusNode();
  bool isNoSliding = false;
  late PointerMoveEvent pointerMoveEvent;
  VideoDetailModel? videoDetailModel;
  PageController pageC = PageController(initialPage: 0);

  Future<void> initViewModel(int? videoId) async {
    textC.clear();
    showComment = false;
    videoDetailModel = null;
    if (videoId != null) {
      VideoDetailModel vdm = await VideoDetailRequest.getVideoDetail(videoId: videoId);
      videoDetailModel = vdm;
      notifyListeners();
    }
  }

  ///打开评论
  void openComment() {
    showComment = true;
    notifyListeners();
  }

  ///关闭评论
  void closeComment() {
    showComment = false;
    notifyListeners();
  }

  void getFocusNode(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).requestFocus(focusNode); // 获取焦点
    });
  }

  bool slidingProcessing(ScrollNotification notification, ScrollController sc) {
    if (notification is UserScrollNotification) {
      if (notification.direction == ScrollDirection.forward && pointerMoveEvent.localDelta.dy > 0 && sc.offset == 0.0) {
        isNoSliding = true;
        notifyListeners();
      }
    }
    return true;
  }

  void slidingListener(PointerMoveEvent value) {
    pointerMoveEvent = value;
    notifyListeners();
    debugPrint("pointerMoveEvent--------------》》${pointerMoveEvent.localDelta.dy}");
    if (pointerMoveEvent.localDelta.dy < 0) {
      isNoSliding = false;
      notifyListeners();
    }
  }

  Future<bool> sendComment(int? videoId, int? userId) async {
    String? token = SpUtil.getString(PublicKeys.token);
    ReleaseCommentModel model = await VideoCommentRequest.releaseComment(
      commentContent: textC.text.trim(),
      videoId: videoId,
      userId: userId,
      token: token,
    );
    if (model.code == 0) {
      if (model.msg != null) ToastUtil.showBottomToast(model.msg!);
      textC.clear();
      return true;
    }
    return false;
  }
}
