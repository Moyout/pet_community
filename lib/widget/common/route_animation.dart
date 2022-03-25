import 'package:flutter/material.dart';

enum RouteAnimation {
  scale,
  popUp,
  popDown,
  popLeft,
  popRight,
  rotation,
  gradient
}

class CustomRoute extends PageRouteBuilder {
  final Widget widget;
  final RouteAnimation? routeAnimation;
  final int millisecond;

  CustomRoute(
    this.widget, {
    this.routeAnimation = RouteAnimation.gradient,
    this.millisecond = 500,
  }) : super(
            // 设置过度时间
            transitionDuration: Duration(milliseconds: millisecond),
            // 构造器
            pageBuilder: (
              // 上下文和动画
              BuildContext context,
              Animation<double> _,
              Animation<double> __,
            ) {
              return widget;
            },
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animaton1,
              Animation<double> animaton2,
              Widget child,
            ) {
              select(RouteAnimation routeAnimation) {
                switch (routeAnimation) {
                  case RouteAnimation.scale:
                    // 缩放动画效果
                    return ScaleTransition(
                      scale: Tween(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animaton1, curve: Curves.fastOutSlowIn)),
                      child: child,
                    );
                  case RouteAnimation.rotation:
                    // 旋转加缩放动画效果
                    return RotationTransition(
                      turns:
                          Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        parent: animaton1,
                        curve: Curves.fastOutSlowIn,
                      )),
                      child: ScaleTransition(
                        scale: Tween(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                                parent: animaton1,
                                curve: Curves.fastOutSlowIn)),
                        child: child,
                      ),
                    );
                  case RouteAnimation.popLeft:
                    // 左右滑动动画效果
                    return SlideTransition(
                      position: Tween<Offset>(
                              // 设置滑动的 X , Y 轴
                              begin: const Offset(-1.0, 0.0),
                              end: const Offset(0.0, 0.0))
                          .animate(CurvedAnimation(
                              parent: animaton1, curve: Curves.fastOutSlowIn)),
                      child: child,
                    );
                  case RouteAnimation.popRight:
                    return SlideTransition(
                      position: Tween<Offset>(
                              // 设置滑动的 X , Y 轴
                              begin: const Offset(1.0, 0.0),
                              end: const Offset(0.0, 0.0))
                          .animate(CurvedAnimation(
                              parent: animaton1, curve: Curves.fastOutSlowIn)),
                      child: child,
                    );
                  case RouteAnimation.popDown:
                    return SlideTransition(
                      position: Tween<Offset>(
                              // 设置滑动的 X , Y 轴
                              begin: const Offset(0.0, 1.0),
                              end: const Offset(0.0, 0.0))
                          .animate(CurvedAnimation(
                              parent: animaton1, curve: Curves.fastOutSlowIn)),
                      child: child,
                    );
                  case RouteAnimation.popUp:
                    return SlideTransition(
                      position: Tween<Offset>(
                              // 设置滑动的 X , Y 轴
                              begin: const Offset(0.0, -1.0),
                              end: const Offset(0.0, 0.0))
                          .animate(CurvedAnimation(
                              parent: animaton1, curve: Curves.fastOutSlowIn)),
                      child: child,
                    );
                  default:
                    // 渐变效果
                    return FadeTransition(
                      // 从0开始到1
                      opacity:
                          Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        // 传入设置的动画
                        parent: animaton1,
                        // 设置效果，快进漫出   这里有很多内置的效果
                        curve: Curves.fastOutSlowIn,
                      )),
                      child: child,
                    );
                }
              }

              return select(routeAnimation!);
              // 渐变效果
//              return FadeTransition(
//                // 从0开始到1
//                opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//                  // 传入设置的动画
//                  parent: animaton1,
//                  // 设置效果，快进漫出   这里有很多内置的效果
//                  curve: Curves.fastOutSlowIn,
//                )),
//                child: child,
//              );
              // 缩放动画效果
              // return ScaleTransition(
              //   scale: Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(
              //     parent: animaton1,
              //     curve: Curves.fastOutSlowIn
              //   )),
              //   child: child,
              // );

              // 旋转加缩放动画效果
              // return RotationTransition(
              //   turns: Tween(begin: 0.0,end: 1.0)
              //   .animate(CurvedAnimation(
              //     parent: animaton1,
              //     curve: Curves.fastOutSlowIn,
              //   )),
              //   child: ScaleTransition(
              //     scale: Tween(begin: 0.0,end: 1.0)
              //     .animate(CurvedAnimation(
              //       parent: animaton1,
              //       curve: Curves.fastOutSlowIn
              //     )),
              //     child: child,
              //   ),
              // );

              // 左右滑动动画效果
//         return SlideTransition(
//           position: Tween<Offset>(
//             // 设置滑动的 X , Y 轴
//             begin: Offset(-1.0, 0.0),
//             end: Offset(0.0,0.0)
//           ).animate(CurvedAnimation(
//             parent: animaton1,
//             curve: Curves.fastOutSlowIn
//           )),
//           child: child,
//         );
            });
}
