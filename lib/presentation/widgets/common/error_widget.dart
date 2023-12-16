import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.assetName,
    required this.errorString,
  });

  final String assetName;
  final String errorString;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.1,
        ),
        Lottie.asset('assets/$assetName', height: 280, width: 280),
        Text(
          errorString,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.red),
        )
      ],
    );
  }
}
