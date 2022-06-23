import 'package:pet_community/config/api_config.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/verification_model/slide_verification_viewmodel.dart';

class SlideVerificationWidget extends StatefulWidget {
  const SlideVerificationWidget({Key? key}) : super(key: key);

  @override
  State<SlideVerificationWidget> createState() => _SlideVerificationWidgetState();
}

class _SlideVerificationWidgetState extends State<SlideVerificationWidget> {
  @override
  void initState() {
    super.initState();
    context.read<SlideVerificationViewModel>().initViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        child: Container(
          height: 260.w,
          // width: MediaQuery.of(context).size.width - 60.w,
          margin: EdgeInsets.symmetric(horizontal: context.read<SlideVerificationViewModel>().margin),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.w),
          ),
          padding: EdgeInsets.symmetric(horizontal: context.read<SlideVerificationViewModel>().padding, vertical: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: context.read<SlideVerificationViewModel>().picHeight,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Image.network(
                        ApiConfig.baseUrl + "/images/pet${context.watch<SlideVerificationViewModel>().randomIndex}.jpg",
                        height: context.read<SlideVerificationViewModel>().picHeight,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: context.watch<SlideVerificationViewModel>().dxRandom.toDouble() + 40.w,
                    top: context.watch<SlideVerificationViewModel>().dyRandom.toDouble(),
                    child: Container(
                      height: 30.w,
                      width: 30.w,
                      alignment: Alignment.center,
                      child: Container(
                        height: 30.w,
                        width: 30.w,
                        // decoration: BoxDecoration(
                        //   color: Colors.black.withOpacity(context.watch<SlideVerificationViewModel>().opacity),
                        //   borderRadius: BorderRadius.circular(2.w),
                        // ),
                        child: context.watch<SlideVerificationViewModel>().opacity == 0
                            ? null
                            : const Icon(Icons.extension, size: 45, color: Colors.black),
                      ),
                    ),
                  ),
                  Positioned(
                    top: context.watch<SlideVerificationViewModel>().dyRandom.toDouble(),
                    left: context.watch<SlideVerificationViewModel>().sliderDistance,
                    child: Container(
                      height: 30.w,
                      width: 30.w,
                      alignment: Alignment.center,
                      child: Container(
                        height: 30.w,
                        width: 30.w,
                        // decoration: BoxDecoration(
                        //   color: Colors.white.withOpacity(context.watch<SlideVerificationViewModel>().opacity),
                        //   borderRadius: BorderRadius.circular(2.w),
                        // ),
                        child: context.watch<SlideVerificationViewModel>().opacity == 0
                            ? null
                            : const Icon(Icons.extension, size: 45, color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: AnimatedContainer(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      duration: const Duration(milliseconds: 500),
                      height: context.watch<SlideVerificationViewModel>().isPass ? 20.w : 0,
                      color: Colors.greenAccent,
                      child: Text("验证通过", style: TextStyle(fontSize: 12.sp)),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: AnimatedContainer(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      duration: const Duration(milliseconds: 500),
                      height: context.watch<SlideVerificationViewModel>().isShowError ? 20.w : 0,
                      color: Colors.redAccent,
                      child: Text(
                        "请正确拼合图像",
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.w),
              Container(
                // width: 300.w,
                alignment: Alignment.center,
                height: 40.w,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(40.w),
                ),
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "拖动滑块完成拼图",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: context.watch<SlideVerificationViewModel>().sliderDistance,
                      width: 40.w,
                      height: 40.w,
                      child: GestureDetector(
                        onHorizontalDragStart: (DragStartDetails details) =>
                            context.read<SlideVerificationViewModel>().onHorizontalDragStart(details),
                        onHorizontalDragUpdate: (DragUpdateDetails details) =>
                            context.read<SlideVerificationViewModel>().onHorizontalDragUpdate(details, context),
                        onHorizontalDragEnd: (v) =>
                            context.read<SlideVerificationViewModel>().onHorizontalDragEnd(context),
                        child: Container(
                          alignment: Alignment.center,
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(80.w),
                          ),
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 2),
                            child: Icon(
                              Icons.forward,
                              color: ThemeUtil.reversePrimaryColor(context),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.w),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => context.read<SlideVerificationViewModel>().refresh(),
                      child: const Icon(Icons.refresh, color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.clear, color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
