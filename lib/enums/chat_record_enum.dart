enum ChatRecordEnum {
  txt(0, "文本"),
  voice(2, "语音");

  const ChatRecordEnum(this.number, this.msg);

  final int number;
  final String msg;
}
