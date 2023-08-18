import 'package:pet_community/common/app_route.dart';
import 'package:pet_community/models/chat/chat_record_model.dart';
import 'package:pet_community/util/database/chat_record_db.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatRecordViewModel extends ChangeNotifier {
  RefreshController refreshC = RefreshController();
  int page = 1;
  List<ChatRecordModel> list = [];
  bool enablePullUp = true;
  int? otherId;

  ///初始化
  void initViewModel(BuildContext context, int userId) {
    otherId = userId;
    page = 1;
    enablePullUp = true;
    list.clear();
    getUserChatRecord(context, userId);
  }

  ///加载聊天记录
  void getUserChatRecord(BuildContext context, int otherId) async {

    list = await ChatRecordDB.queryChatRecord(
      context.read<NavViewModel>().userInfoModel?.data?.userId,
      otherId,
    );
    // list = list.reversed.toList();
    debugPrint("list--------->${list}");
  }

  ///加载更多聊天记录
  Future<void> onLoad(BuildContext context, int otherId) async {
    List<ChatRecordModel> moreData = await ChatRecordDB.queryChatRecord(
      context.read<NavViewModel>().userInfoModel?.data?.userId,
      otherId,
      page: ++page,
    ).whenComplete(() => refreshC.loadComplete());
    if (moreData.isNotEmpty) {
      list.addAll(moreData);
    } else {
      enablePullUp = false;
    }
    notifyListeners();
    debugPrint("list-w-------->${list}");
  }

  ///新信息添加到底部
  wsInsertRecord(ChatRecordModel crm, int wsOtherId) {
    if (otherId == wsOtherId) {
      list.insert(0, crm);
    }
  }
}
