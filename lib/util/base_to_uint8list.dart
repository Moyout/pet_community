import 'dart:convert';
import 'dart:typed_data';

class BaseToUint8List {
  Uint8List base64ToImage(String base) {
    String captchaCode = base.split(',')[1]; //'iVBORw0KGgoAAAANSUhEUg.....' 正确格式
    //debugPrint(captchaCode);
    Uint8List bytes = const Base64Decoder().convert(captchaCode);
    //debugPrint("bytes-------->$bytes");
    return bytes;
  }
}
