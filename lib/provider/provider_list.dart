import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/community/community_detail_viewmodel.dart';
import 'package:pet_community/view_models/community/community_viewmodel.dart';
import 'package:pet_community/view_models/community/user/user_info_viewmodel.dart';
import 'package:pet_community/view_models/home/home_viewmodel.dart';
import 'package:pet_community/view_models/home/video_detail_viewmodel.dart';
import 'package:pet_community/view_models/home/video_viewmodel.dart';
import 'package:pet_community/view_models/init_viewmodel.dart';
import 'package:pet_community/view_models/message/chat_viewmodel.dart';
import 'package:pet_community/view_models/mine/edit_data/edit_data_viewmodel.dart';
import 'package:pet_community/view_models/mine/edit_data/edit_viewmodel.dart';
import 'package:pet_community/view_models/mine/mine_viewmodel.dart';
import 'package:pet_community/view_models/mine/work/release_work_viewmodel.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/view_models/sign_login/login_viewmodel.dart';
import 'package:pet_community/view_models/sign_login/sign_login_viewmodel.dart';
import 'package:pet_community/view_models/sign_login/sign_viewmodel.dart';
import 'package:pet_community/view_models/startup_viewmodel.dart';
import 'package:pet_community/view_models/verification_model/slide_verification_viewmodel.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider(create: (_) => InitAppViewModel()),
  ChangeNotifierProvider(create: (_) => StartUpViewModel()),
  ChangeNotifierProvider(create: (_) => NavViewModel()),
  ChangeNotifierProvider(create: (_) => CommunityViewModel()),
  ChangeNotifierProvider(create: (_) => CommunityDetailViewModel()),
  ChangeNotifierProvider(create: (_) => MineViewModel()),
  ChangeNotifierProvider(create: (_) => SlideVerificationViewModel()),
  ChangeNotifierProvider(create: (_) => SignLoginViewModel()),
  ChangeNotifierProvider(create: (_) => SignViewModel()),
  ChangeNotifierProvider(create: (_) => LoginViewModel()),
  ChangeNotifierProvider(create: (_) => EditDataViewModel()),
  ChangeNotifierProvider(create: (_) => EditViewModel()),
  ChangeNotifierProvider(create: (_) => ReleaseWorkViewModel()),
  ChangeNotifierProvider(create: (_) => UserInfoViewModel()),
  ChangeNotifierProvider(create: (_) => HomeViewModel()),
  ChangeNotifierProvider(create: (_) => VideoViewModel()),
  ChangeNotifierProvider(create: (_) => VideoDetailViewModel()),
  ChangeNotifierProvider(create: (_) => ChatViewModel()),
];

//这里使用ProxyProvider来定义需要依赖其他Provider的服务
List<SingleChildWidget> dependentServices = [];
