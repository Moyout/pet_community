import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/mine/work/release_work_viewmodel.dart';

class ReleaseWorkView extends StatefulWidget {
  static const String routeName = 'ReleaseWorkView';

  const ReleaseWorkView({Key? key}) : super(key: key);

  @override
  State<ReleaseWorkView> createState() => _ReleaseWorkViewState();
}

class _ReleaseWorkViewState extends State<ReleaseWorkView> {
  @override
  void initState() {
    super.initState();
    context.read<ReleaseWorkViewModel>().initViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => RouteUtil.pop(context),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 18,
              color: ThemeUtil.reversePrimaryColor(context),
            ),
          ),
          title: Text("发布作品", style: TextStyle(fontSize: 14.sp)),
          actions: [
            Center(
              child: SizedBox(
                height: 25.w,
                width: 45.w,
                child: TextButton(
                  onPressed: (context.watch<ReleaseWorkViewModel>().textC.text.trim().isNotEmpty ||
                          context.watch<ReleaseWorkViewModel>().fileList.isNotEmpty)
                      ? () => context.read<ReleaseWorkViewModel>().onSubmit(context)
                      : null,
                  style: TextButton.styleFrom(
                    backgroundColor: (context.watch<ReleaseWorkViewModel>().textC.text.trim().isNotEmpty ||
                            context.watch<ReleaseWorkViewModel>().fileList.isNotEmpty)
                        ? const Color(0xff07C160)
                        : Colors.grey,
                    primary: Colors.white,
                    padding: EdgeInsets.zero,
                  ),
                  child: Text("发表", style: TextStyle(fontSize: 12.sp)),
                ),
              ),
            ),
            SizedBox(width: 10.w)
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5.w),
                  ),
                  child: TextField(
                    onChanged: (v) => context.read<ReleaseWorkViewModel>().notifyListeners(),
                    controller: context.watch<ReleaseWorkViewModel>().titleC,
                    maxLength: 20,
                    minLines: 1,
                    style: const TextStyle(letterSpacing: 1.2, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "#标题",
                      counterText: "",
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5.w),
                  ),
                  child: TextField(
                    onChanged: (v) => context.read<ReleaseWorkViewModel>().notifyListeners(),
                    controller: context.watch<ReleaseWorkViewModel>().textC,
                    maxLines: 6,
                    maxLength: 200,
                    style: const TextStyle(letterSpacing: 1.2),
                    decoration: const InputDecoration(border: InputBorder.none, hintText: "#内容"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    runSpacing: 5.w,
                    spacing: 5.w,
                    alignment: WrapAlignment.start,
                    children: [
                      ...List.generate(
                        context.watch<ReleaseWorkViewModel>().fileList.length,
                        (index) {
                          return SizedBox(
                            width: 100.w,
                            height: 100.w,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  right: 10.w,
                                  top: 10.w,
                                  bottom: 0,
                                  child: Image.file(
                                    context.watch<ReleaseWorkViewModel>().fileList[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  width: 20.w,
                                  height: 20.w,
                                  child: GestureDetector(
                                    onTap: () => context.read<ReleaseWorkViewModel>().removePicture(index),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: ThemeUtil.reversePrimaryColor(context),
                                        borderRadius: BorderRadius.circular(15.w),
                                        border: Border.all(color: Colors.white),
                                      ),
                                      child: Icon(Icons.close, color: ThemeUtil.primaryColor(context), size: 15),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      if (context.watch<ReleaseWorkViewModel>().fileList.length < 9)
                        Container(
                          margin: EdgeInsets.only(top: 10.w),
                          width: 90.w,
                          height: 90.w,
                          color: Colors.grey.withOpacity(0.2),
                          child: TextButton(
                            onPressed: () => context.read<ReleaseWorkViewModel>().selectPicture(),
                            child: const Icon(Icons.add, size: 40),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
