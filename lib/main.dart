import 'package:pet_community/provider/provider_list.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/init_viewmodel.dart';
import 'package:pet_community/views/startup_view.dart';

void main() {
  Provider.debugCheckInvalidValueType = null; //Provider 状态管理，同步数据
  WidgetsFlutterBinding.ensureInitialized(); //WidgetsFlutterBinding 承担各类的初始化以及功能配置
  ScreenUtil.initialize(); //初始化屏幕适配
  AppConfig.initSp(); //初始化SP
  AppConfig.errorWidget(); //错误widget
  AppConfig.setScreenOrientations(); //竖屏
  runApp(MultiProvider(providers: providers, child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.initialize(); //初始化屏幕适配
    return MaterialApp(
      title: 'Flutter mall template',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate
      ],
      debugShowCheckedModeBanner: false,
      navigatorKey: AppUtils.navigatorKey,
      themeMode: context.watch<InitAppViewModel>().isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeUtil.lightTheme(),
      darkTheme: ThemeUtil.darkTheme(),
      home: const StartUpView(),
    );
  }
}
