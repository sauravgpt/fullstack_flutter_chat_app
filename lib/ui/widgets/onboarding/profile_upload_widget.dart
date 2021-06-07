import 'package:flutter/material.dart';
import 'package:fullstack_chat_app/colors.dart';
import 'package:fullstack_chat_app/theme.dart';

class ProfileUpload extends StatelessWidget {
  const ProfileUpload();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 126,
      width: 126,
      child: Material(
        color: isLightTheme(context) ? Color(0xFFF2F2F2) : Color(0xFF211E1E),
        borderRadius: BorderRadius.circular(126.0),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(126),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.person_outline_rounded,
                  size: 126,
                  color: isLightTheme(context) ? kIconLight : Colors.black,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.add_circle_rounded,
                  color: kPrimary,
                  size: 38,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
