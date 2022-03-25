import 'package:pet_community/util/tools.dart';

///路由
class RouteUtil {
  static void push(BuildContext context, Widget widget, {RouteAnimation? animation = RouteAnimation.gradient}) {
    Navigator.push(context, CustomRoute(widget, routeAnimation: animation!));
  }

  static void push2(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => widget));
  }

  static void pop<T extends Object>(BuildContext context, [T? result]) {
    Navigator.of(context).pop<T>(result);
  }

  static void pushReplacement(BuildContext context, Widget widget,
      {RouteAnimation? animation = RouteAnimation.gradient}) {
    Navigator.pushReplacement(context, CustomRoute(widget, routeAnimation: animation!));
  }
}
