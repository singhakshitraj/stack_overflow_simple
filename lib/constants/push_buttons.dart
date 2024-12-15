import 'package:flutter/material.dart';

class PushButton {
  Widget displayButton(String pngPath, String text, Function() onPress) {
    return SizedBox(
      width: 120,
      height: 140,
      child: Padding(
        padding: const EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
        child: ElevatedButton(
          onPressed: onPress,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                pngPath,
                fit: BoxFit.fill,
              ),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
