import 'package:pet_community/enums/drag_state_enum.dart';
import 'package:pet_community/util/tools.dart';

class MineViewModel extends ChangeNotifier {
  static double offsetY = 0;
  static double defaultHeight = 220.w;
  static double maxHeight = 320.w;
  static double distance = maxHeight - defaultHeight;
  final ScrollController controller = ScrollController(initialScrollOffset: distance - 10);
  DragState dragState = DragState.dragStateIdle;
  double scale = 0;

  /// 初始化viewModel
  void initViewModel() {
    controller.addListener(() {
      offsetY = controller.offset;
      if (offsetY == 0.0) {
        restWithAnimation(true);
      }
      if (offsetY < distance) {
        scale = (1 - offsetY / distance).abs();
      }

      notifyListeners();
    });
  }

  //缩放
  restWithAnimation(bool delay) {
    Future.delayed(Duration(milliseconds: delay ? 200 : 0)).then((value) {
      if (controller.offset < distance && dragState == DragState.dragStateEnd) {
        dragState = DragState.dragStateIdle;
        controller.animateTo(distance, duration: const Duration(milliseconds: 300), curve: Curves.linear);
        return;
      }
    });
  }
}
