import 'package:flutter/material.dart';

class HomeTimerButton extends StatelessWidget {
  const HomeTimerButton({
    super.key,
    required this.text,
    this.bgColor,
    this.textColor,
    this.onPressed,
  });

  final Color? bgColor;
  final Color? textColor;
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
