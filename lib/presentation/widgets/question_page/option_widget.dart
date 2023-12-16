import 'package:flutter/material.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget({
    super.key,
    required this.clickedIndex,
    required this.optionText,
    required this.questionIndex,
    required this.onPressed,
  });

  final int clickedIndex;
  final void Function() onPressed;
  final int questionIndex;
  final String optionText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: clickedIndex == questionIndex
                  ? const Color(0xff424045)
                  : const Color(0xffFCFAFF),
              border:
                  Border.all(color: const Color.fromARGB(255, 233, 233, 233)),
              borderRadius: BorderRadius.circular(50)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      color: clickedIndex == questionIndex
                          ? const Color.fromARGB(255, 83, 82, 85)
                          : const Color.fromARGB(255, 233, 233, 233),
                      shape: BoxShape.circle),
                  child: Center(
                      child: Text(
                    questionIndex.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: clickedIndex == questionIndex
                            ? const Color.fromARGB(255, 233, 233, 233)
                            : const Color(0xff424045)),
                  )),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    optionText,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: clickedIndex == questionIndex
                            ? const Color.fromARGB(255, 233, 233, 233)
                            : const Color(0xff424045)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
