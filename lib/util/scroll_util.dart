import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:pet_community/util/tools.dart';

class ScrollUtils {
  final PageController pageController;
  final TabController tabController;
  Drag? _drag;

  ScrollUtils(this.pageController, this.tabController);

  bool handleNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification) {
      if (notification.direction == ScrollDirection.reverse && tabController.index == tabController.length - 1) {
        _drag = pageController.position.drag(DragStartDetails(), () {
          _drag = null;
        });
      }
      if (notification.direction == ScrollDirection.forward && tabController.index == 0) {
        _drag = pageController.position.drag(DragStartDetails(), () {
          _drag = null;
        });
      }
    }
    if (notification is OverscrollNotification) {
      if (notification.dragDetails != null && _drag != null) {
        _drag?.update(notification.dragDetails!);
      }
    }
    if (notification is ScrollEndNotification) {
      if (notification.dragDetails != null && _drag != null) {
        _drag?.end(notification.dragDetails!);
      }
    }
    return true;
  }
}
