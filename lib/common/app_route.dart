import 'package:pet_community/util/tools.dart';
import 'package:pet_community/views/community/detail/community_detail_view.dart';
import 'package:pet_community/views/community/detail/show_picture_view.dart';
import 'package:pet_community/views/home/video/video_detail_view.dart';
import 'package:pet_community/views/message/chat/chat_view.dart';
import 'package:pet_community/views/mine/avatar/set_avatar_view.dart';
import 'package:pet_community/views/mine/background/set_background_view.dart';
import 'package:pet_community/views/mine/edit_data/edit_data_view.dart';
import 'package:pet_community/views/mine/edit_data/edit_view.dart';
import 'package:pet_community/views/mine/work/release_work2_view.dart';
import 'package:pet_community/views/mine/work/release_work_view.dart';
import 'package:pet_community/views/navigation_view.dart';
import 'package:pet_community/views/sign_login/sign_login_view.dart';
import 'package:pet_community/views/startup_view.dart';
import 'package:pet_community/views/test_view.dart';

class AppRoute extends NavigatorObserver {
  static String? currRoute;

  static Map<String, WidgetBuilder> routes = {
    NavigationView.routeName: (context) => const NavigationView(),
    StartUpView.routeName: (context) => const StartUpView(),
    SignLoginView.routeName: (context) => const SignLoginView(),
    // SignView.routeName: (context) => const SignView(),
    // LoginView.routeName: (context) => const LoginView(),
    ReleaseWorkView.routeName: (context) => const ReleaseWorkView(),
    EditDataView.routeName: (context) => const EditDataView(),
    TestView.routeName: (context) => const TestView(),
    ReleaseWork2View.routeName: (context) => const ReleaseWork2View(),
    EditView.routeName: (context) => EditView(title: (ModalRoute.of(context)?.settings.arguments as Map)["title"]),
    SetBackgroundView.routeName: (context) => SetBackgroundView(
          background: '${(ModalRoute.of(context)?.settings.arguments as Map)["background"]}',
          isOther: (ModalRoute.of(context)?.settings.arguments as Map)["isOther"] ?? false,
        ),
    SetAvatarView.routeName: (context) => SetAvatarView(
          avatar: (ModalRoute.of(context)?.settings.arguments as Map)["avatar"],
          isOther: (ModalRoute.of(context)?.settings.arguments as Map)["arguments"] ?? false,
        ),
    ChatView.routeName: (context) => ChatView(userId: (ModalRoute.of(context)?.settings.arguments as Map)["userId"]),
    VideoDetailView.routeName: (context) => VideoDetailView(
          videoId: (ModalRoute.of(context)?.settings.arguments as Map)["videoId"],
          videoUrl: (ModalRoute.of(context)?.settings.arguments as Map)["videoUrl"],
          picUrl: (ModalRoute.of(context)?.settings.arguments as Map)["picUrl"],
          index: (ModalRoute.of(context)?.settings.arguments as Map)["index"],
          userId: (ModalRoute.of(context)?.settings.arguments as Map)["userId"],
          content: (ModalRoute.of(context)?.settings.arguments as Map)["content"],
        ),
    CommunityDetailView.routeName: (context) => CommunityDetailView(
          title: (ModalRoute.of(context)?.settings.arguments as Map)["title"],
          content: (ModalRoute.of(context)?.settings.arguments as Map)["content"],
          articleId: (ModalRoute.of(context)?.settings.arguments as Map)["articleId"],
          pictures: (ModalRoute.of(context)?.settings.arguments as Map)["pictures"],
          userId: (ModalRoute.of(context)?.settings.arguments as Map)["userId"],
          isShowUserInfoView: (ModalRoute.of(context)?.settings.arguments as Map)["isShowUserInfoView"],
        ),
    ShowPictureView.routeName: (context) => ShowPictureView(
          picUrlList: (ModalRoute.of(context)?.settings.arguments as Map)["picUrlList"],
          index: (ModalRoute.of(context)?.settings.arguments as Map)["index"],
        ),
  };

  @override
  void didPop(Route? route, Route? previousRoute) {
    super.didPop(route!, previousRoute);
    String? previousName;
    previousName = previousRoute?.settings.name;

    currRoute = previousName;
    debugPrint('YM----->  Pop--上一个:   ${route.settings.name}     当前:$previousName');
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);

    String? previousName;
    if (previousRoute != null) {
      previousName = previousRoute.settings.name;
    }
    currRoute = route.settings.name;
    debugPrint('YM------- Push--当前: ${route.settings.name}   Previous:$previousName');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    currRoute = route.settings.name;
    debugPrint('YM------- didRemove--当前: ${route.settings.name}   Previous:$previousRoute');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace();
    currRoute = newRoute?.settings.name;
    debugPrint('YM------- didReplace--当前: ${newRoute?.settings.name}   Previous:${oldRoute?.settings.name}');
  }
}
