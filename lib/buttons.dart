import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final String buttonText;
  final buttonPressed;

  const MyButtons({
    super.key,
    required this.buttonColor,
    required this.textColor,
    required this.buttonText,
    required this.buttonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: buttonPressed,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: buttonColor,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 20,
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
