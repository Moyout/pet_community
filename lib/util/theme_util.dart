///
///author: DJT
///created on: 2021/8/2 5:18
///
import 'package:pet_community/util/tools.dart';

class ThemeUtil {
  ///日间模式
  static ThemeData lightTheme() {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    return ThemeData(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.grey[300],
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        color: Colors.grey[200],
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(fontSize: 14.sp, color: Colors.black),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      dividerColor: Colors.blueGrey,
      brightness: Brightness.light,
      tabBarTheme: TabBarTheme(
        labelColor: Colors.black,
        labelPadding: EdgeInsets.all(2.w),
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor: Colors.black54,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          // overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.5)),
          // backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
      // scrollbarTheme: ScrollbarThemeData(
      //   trackColor: MaterialStateProperty.all(Colors.red),
      //   thumbColor: MaterialStateProperty.all(Colors.green),
      //   trackBorderColor: MaterialStateProperty.all(Colors.yellow),
      //   thickness: MaterialStateProperty.all(10),
      //  ),
    );
  }

  ///深夜模式
  static ThemeData darkTheme() {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    return ThemeData(
      primaryColor: const Color(0xff1c1c1c),
      scaffoldBackgroundColor: Colors.black54,
      textTheme: TextTheme(
        bodyMedium: TextStyle(fontSize: 14.sp, color: const Color(0xffeeeeee)),
      ),
      iconTheme: const IconThemeData(color: Color(0xffb9b9b9)),
      dividerColor: Colors.grey,
      brightness: Brightness.dark,
      dialogTheme: const DialogTheme(
          // backgroundColor: Colors.red
          ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        color: const Color(0xff1c1c1c),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.white,
        labelPadding: EdgeInsets.all(2.w),
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor: Colors.grey,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          // overlayColor: MaterialStateProperty.all(Colors.blueGrey.withOpacity(0.5)),
          backgroundColor: MaterialStateProperty.all(Colors.black87),
          foregroundColor: MaterialStateProperty.all(const Color(0xffeeeeee)),
        ),
      ),
    );
  }

  static Color primaryColor(BuildContext context) => Theme.of(context).primaryColor;

  static Color reversePrimaryColor(BuildContext context) => Theme.of(context).dividerColor;

  static Color scaffoldColor(BuildContext context) => Theme.of(context).scaffoldBackgroundColor;

  static Brightness brightness(BuildContext context) => Theme.of(context).brightness;
}
