import 'package:flutter/material.dart';
import 'package:fullstack_chat_app/colors.dart';
import 'package:fullstack_chat_app/theme.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final Function(String val) onChanged;
  final double height;
  final TextInputAction inputAction;

  const CustomTextField({
    this.height = 54.0,
    @required this.hint,
    @required this.onChanged,
    @required this.inputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: isLightTheme(context) ? Colors.white : kBubbleDark,
        border: Border.all(
          color: isLightTheme(context) ? Color(0xFFC4C4C4) : Color(0xFF393737),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(45),
      ),
      child: TextField(
        keyboardType: TextInputType.text,
        onChanged: onChanged,
        textInputAction: inputAction,
        cursorColor: kPrimary,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
          hintText: hint,
          border: InputBorder.none,
        ),
        style: TextStyle(
          color: isLightTheme(context) ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
