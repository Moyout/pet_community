import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/init_viewmodel.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/view_models/startup_viewmodel.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider(create: (_) => InitAppViewModel()),
  ChangeNotifierProvider(create: (_) => StartUpViewModel()),
  ChangeNotifierProvider(create: (_) => NavViewModel()),
];

//这里使用ProxyProvider来定义需要依赖其他Provider的服务
List<SingleChildWidget> dependentServices = [];
