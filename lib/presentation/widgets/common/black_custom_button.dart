import 'package:flutter/material.dart';

class BlackCustomButton extends StatelessWidget {
  const BlackCustomButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(6),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: const Color(0xff424045),
            // border: Border.all(color: const Color.fromARGB(255, 233, 233, 233)),
            borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xffFCFAFF)),
          ),
        ),
      ),
    );
  }
}
