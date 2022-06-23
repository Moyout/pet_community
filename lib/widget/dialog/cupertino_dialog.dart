import 'package:flutter/cupertino.dart';
import 'package:pet_community/util/tools.dart';

class CupertinoDialog extends StatelessWidget {
  final String title, content, yes, no;
  final VoidCallback? onYes;

  const CupertinoDialog({
    this.onYes,
    this.title = "",
    this.content = "",
    this.yes = "确认",
    this.no = "取消",
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title, style: TextStyle(fontSize: 14.sp)),
      content: Text(
        content,
        style: TextStyle(fontSize: 14.sp),
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(
            no,
            style: TextStyle(color: ThemeUtil.reversePrimaryColor(context), fontSize: 14.sp),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        CupertinoDialogAction(
          child: Text(yes, style: TextStyle(fontSize: 14.sp)),
          onPressed: onYes,
        ),
      ],
    );
  }
}
