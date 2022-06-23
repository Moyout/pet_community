import 'package:pet_community/util/tools.dart';

class TextFileWidget extends StatelessWidget {
  final TextEditingController? controller;

  final bool showCursor;
  final bool isHide;
  final bool readOnly;
  final int maxLength;
  final Widget? rightIcon;
  final Widget? leftIcon;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatter;
  final Function? onSubmitted;
  final Function? onChanged;
  final Function? onTap;
  final Iterable<String>? autofillHints;

  const TextFileWidget({
    Key? key,
    this.showCursor = true,
    this.maxLength = 11,
    this.rightIcon,
    this.leftIcon,
    this.hintText,
    this.inputFormatter,
    this.onSubmitted,
    this.onChanged,
    this.onTap,
    this.controller,
    this.readOnly = false,
    this.isHide = false,
    this.autofillHints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      controller: controller,
      style: const TextStyle(letterSpacing: 1.5),
      onTap: () {
        if (onTap != null) onTap!();
      },
      onSubmitted: (v) {
        if (onSubmitted != null) onSubmitted!();
      },
      onChanged: (v) {
        if (onChanged != null) onChanged!();
      },
      scrollPadding: EdgeInsets.zero,
      inputFormatters: inputFormatter,
      obscureText: isHide,
      maxLength: maxLength,
      autofillHints: autofillHints,
      decoration: InputDecoration(
        prefixIcon: leftIcon,
        suffixIcon: rightIcon,
        hintText: hintText,
        contentPadding: const EdgeInsets.all(0).add(EdgeInsets.symmetric(horizontal: 5.w)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.w),
        ),
        counter: const SizedBox(),
      ),
    );
  }
}
