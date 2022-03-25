///
///author: DJT
///created on: 2021/8/2 5:18
///

import 'dart:ui';
import 'package:pet_community/util/tools.dart';

class ThemeUtil {
  ///日间模式
  static ThemeData lightTheme() {
    return ThemeData(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.grey[200],
      textTheme: TextTheme(
        bodyText2: TextStyle(fontSize: 14.sp, color: Colors.black),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      dividerColor: Colors.blueGrey,
      brightness: Brightness.light,
    );
  }

  ///深夜模式
  static ThemeData darkTheme() {
    return ThemeData(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.blueGrey,
      textTheme: TextTheme(
        bodyText2: TextStyle(fontSize: 14.sp, color: Colors.white),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      dividerColor: Colors.white,
      brightness: Brightness.dark,
      dialogTheme: const DialogTheme(),

      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ButtonStyle(
      //     backgroundColor: MaterialStateProperty.all(Colors.blue),
      //     textStyle: MaterialStateProperty.all(
      //       TextStyle(color: Colors.red, fontSize: 14.sp,fontFamily: "FZKT"),
      //     ),
      //   ),
      // ),
    );
  }

  static Color primaryColor(BuildContext context) => Theme.of(context).primaryColor;

  static Color scaffoldColor(BuildContext context) => Theme.of(context).scaffoldBackgroundColor;

  static Brightness brightness(BuildContext context) => Theme.of(context).brightness;
}
