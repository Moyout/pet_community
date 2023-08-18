import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/mine/edit_data/edit_viewmodel.dart';

class EditView extends StatefulWidget {
  static const String routeName = 'EditView';
  final String title;

  const EditView({Key? key, required this.title}) : super(key: key);

  @override
  State<EditView> createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  @override
  void initState() {
    super.initState();
    context.read<EditViewModel>().initViewModel(widget.title, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeUtil.primaryColor(context),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeUtil.primaryColor(context),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios, color: ThemeUtil.reversePrimaryColor(context), size: 18),
        ),
        title: Text(widget.title, style: TextStyle(fontSize: 14.sp)),
        actions: [
          GestureDetector(
            onTap: () => context.read<EditViewModel>().saveEditData(widget.title, context),
            child: Align(
              child: Text("保存", style: TextStyle(color: Colors.redAccent, fontSize: 14.sp)),
              alignment: Alignment.centerLeft,
            ),
          ),
          SizedBox(width: 10.w),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(18.0.w),
              child: TextField(
                controller: context.watch<EditViewModel>().textC,
                style: const TextStyle(letterSpacing: 1.2),
                maxLength: widget.title == "修改名字" ? 20 : null,
                maxLines: widget.title == "修改名字" ? null : 20,
                decoration: InputDecoration(
                  hintText: widget.title,
                  border: widget.title == "修改名字" ? null : InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
