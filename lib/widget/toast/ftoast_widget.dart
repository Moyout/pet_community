import 'package:pet_community/util/tools.dart';

class FToastUtil {
  // static FToastUtil? _fToastUtil;
  // static FToast? _fToast;
  //
  // static final Lock _lock = Lock();
  //
  // static Future<FToastUtil> getInstance(BuildContext context) async {
  //   if (_fToastUtil == null) {
  //     await _lock.synchronized(() async {
  //       if (_fToastUtil == null) {
  //         // 保持本地实例直到完全初始化。
  //         var singleton = FToastUtil._();
  //         singleton._init(context);
  //         _fToastUtil = singleton;
  //       }
  //     });
  //   }
  //   return _fToastUtil!;
  // }
  //
  // FToastUtil._();
  //
  // void _init(BuildContext context) {
  //   _fToast = FToast().init(context);
  // }
  //
  // static void showToast() {
  //   _fToast?.showToast(
  //     child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
  //       return Container(child: Text("这是toast"));
  //     }),
  //     gravity: ToastGravity.BOTTOM,
  //     toastDuration: Duration(seconds: 2),
  //   );
  // }

  static FToast toast = FToast();

  static void showToast(
    BuildContext context, {
    required GlobalKey widgetKey,
    required String text,
  }) {
    toast.init(context);
    toast.removeCustomToast();
    RenderBox renderBox = widgetKey.currentContext?.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset(0, renderBox.size.height));
    toast.showToast(
      toastDuration: const Duration(seconds: 2),
      child: Text(
        text,
        style: TextStyle(fontSize: 10.sp),
      ),
      positionedToastBuilder: (BuildContext context, Widget child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: offset.dy,
              left: offset.dx + renderBox.size.width / 3,
              child: Container(
                width: 12.w,
                height: 0,
                decoration: BoxDecoration(
                  border: Border(
                    // 四个值 top right bottom left
                    bottom: BorderSide(color: Colors.grey.withOpacity(0.8), width: 6.w),
                    right: BorderSide(color: Colors.grey.withOpacity(0.8), width: 6.w),
                    left: BorderSide(color: Colors.grey.withOpacity(0.8), width: 6.w),
                  ),
                ),
              ),
            ),
            Positioned(
              top: offset.dy,
              left: offset.dx,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(4.w),
                ),
                child: child,
              ),
            ),
          ],
        );
      },
    );
  }
}
