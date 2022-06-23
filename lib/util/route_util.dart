import 'package:flutter/cupertino.dart';
import 'package:pet_community/util/tools.dart';

///路由
class RouteUtil {
  static void push(
    BuildContext context,
    Widget widget, {
    RouteAnimation? animation = RouteAnimation.gradient,
    int millisecond = 500,
  }) {
    Navigator.push(context, CustomRoute(widget, routeAnimation: animation!, millisecond: millisecond));
  }

  static void pushByMaterial(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => widget));
  }

  static void pushByCupertino(BuildContext context, Widget widget) {
    Navigator.push(context, CupertinoPageRoute(builder: (_) => widget));
  }

  static void pop<T extends Object>(BuildContext context, [T? result]) {
    Navigator.of(context).pop<T>(result);
  }

  static void pushReplacement(BuildContext context, Widget widget,
      {RouteAnimation? animation = RouteAnimation.gradient}) {
    Navigator.pushReplacement(context, CustomRoute(widget, routeAnimation: animation!));
  }

  static void pushAndRemoveUntil(BuildContext context, Widget widget,
      {RouteAnimation? animation = RouteAnimation.gradient}) {
    Navigator.pushAndRemoveUntil(context, CustomRoute(widget, routeAnimation: animation!), (route) => false);
  }
}
