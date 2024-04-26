import 'package:flutter/cupertino.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/mine/edit_data/edit_data_viewmodel.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/view_models/startup_viewmodel.dart';
import 'package:pet_community/views/mine/edit_data/edit_view.dart';

class EditDataView extends StatefulWidget {
  static const String routeName = 'EditDataView';

  const EditDataView({Key? key}) : super(key: key);

  @override
  State<EditDataView> createState() => _EditDataViewState();
}

class _EditDataViewState extends State<EditDataView> {
  TextStyle titleText = TextStyle(color: Colors.grey, fontSize: 14.sp);
  TextStyle valueText = TextStyle(fontSize: 14.sp);

  @override
  void initState() {
    super.initState();
    context.read<EditDataViewModel>().initViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUtil.primaryColor(context),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeUtil.primaryColor(context),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios, color: ThemeUtil.reversePrimaryColor(context), size: 18),
        ),
        title: Text("编辑资料", style: TextStyle(fontSize: 14.sp)),
        centerTitle: true,
      ),
      body: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 25.w),
              Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50.w)),
                  border: Border.all(color: Colors.white, width: 3.w),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Hero(
                      tag: "avatar",
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: context.watch<NavViewModel>().userInfoModel?.data?.avatar ??
                              ApiConfig.baseUrl + "/images/pet${context.read<StartUpViewModel>().random}.jpg",
                          width: 100.w,
                          height: 100.w,
                          fit: BoxFit.cover,
                          placeholder: (c, w) => CupertinoActivityIndicator(),
                        ),
                        // child: Image.network(
                        //   context.watch<NavViewModel>().userInfoModel?.data?.avatar ??
                        //       ApiConfig.baseUrl + "/images/pet${context.read<StartUpViewModel>().random}.jpg",
                        //   width: 100.w,
                        //   height: 100.w,
                        //   fit: BoxFit.cover,
                        //   loadingBuilder: (context, child, loadingProgress) => loadingProgress != null
                        //       ? const Center(
                        //           child: CupertinoActivityIndicator(),
                        //         )
                        //       : child,
                        // ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => context.read<EditDataViewModel>().setAvatar(context),
                        child: ClipOval(
                          child: Container(
                            color: Colors.black.withOpacity(0.4),
                            child: const Icon(Icons.camera_alt, color: Colors.white, size: 32),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.w),
              Text(
                "点击更换头像",
                style: TextStyle(color: ThemeUtil.reversePrimaryColor(context), fontSize: 12.sp),
              ),
              SizedBox(height: 10.w),
              ListTile(
                leading: Text("名字", style: titleText),
                title: Text(
                  context.watch<NavViewModel>().userInfoModel?.data?.userName ?? "--",
                  style: valueText,
                ),
                trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                onTap: () => RouteUtil.pushNamed(
                  context,
                  EditView.routeName,
                  arguments: {"title": "修改名字"},
                ),
              ),
              ListTile(
                leading: Text("性别", style: titleText),
                title: Text(
                  context.watch<NavViewModel>().userInfoModel?.data?.sex ?? "--",
                  style: valueText,
                ),
                trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 160.w,
                        // padding: EdgeInsets.symmetric(vertical: 10.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10.w)),
                        ),
                        child: Column(
                          children: ["男", null, "女", null, "保密", null, "取消"].map((e) {
                            return e == null
                                ? const Divider(color: Colors.black, height: 0, thickness: 0.1)
                                : Expanded(
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: TextButton(
                                        child: Text(e.toString()),
                                        style:
                                            TextButton.styleFrom(primary: Colors.black, backgroundColor: Colors.white),
                                        onPressed: () => e == "取消"
                                            ? Navigator.pop(context)
                                            : context.read<EditDataViewModel>().setUserSex(e.toString(), context),
                                      ),
                                    ),
                                  );
                          }).toList(),
                        ),
                      );
                    },
                  );
                },
              ),
              ListTile(
                leading: Text("简介", style: titleText),
                title: Text(
                  context.watch<NavViewModel>().userInfoModel?.data?.signature ?? "--",
                  style: valueText,
                ),
                trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                onTap: () => RouteUtil.pushNamed(context, EditView.routeName, arguments: {"title": "修改简介"}),
              ),
              ListTile(
                leading: Text("地区", style: titleText),
                title: Text(
                  context.watch<NavViewModel>().userInfoModel?.data?.area ?? "--",
                  style: valueText,
                ),
                trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                onTap: () => Pickers.showAddressPicker(
                  context,
                  initTown: "",
                  addAllItem: false,
                  pickerStyle: PickerStyle(
                    pickerHeight: 150.w,
                    pickerTitleHeight: 40.w,
                    cancelButton: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Text(
                        "不设置",
                        style: TextStyle(color: Colors.redAccent, fontSize: 14.sp),
                      ),
                    ),
                    commitButton: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Text(
                        "确定",
                        style: TextStyle(color: Colors.blue, fontSize: 14.sp),
                      ),
                    ),
                  ),
                  onConfirm: (String province, String city, String? town) {
                    String area = province + " · " + city + " · " + town!;
                    context.read<EditDataViewModel>().setUserArea(area);
                  },
                  onCancel: (bool isCancel) {
                    debugPrint("isCancel--------->$isCancel");
                    if (isCancel) {
                      context.read<EditDataViewModel>().setUserArea("未设置");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
