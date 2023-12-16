import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:komodo_trivia/presentation/widgets/common/black_custom_button.dart';
import 'package:shimmer/shimmer.dart';

class QuestionsLoadingWidget extends StatelessWidget {
  const QuestionsLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xffF1F1F1),
      highlightColor: Colors.grey.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Container(
            height: 20,
            width: 80,
            decoration: const BoxDecoration(color: Colors.white),
          ),
          const SizedBox(height: 4),
          Container(
            height: 60,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
          ),
          const SizedBox(height: 15),
          LayoutGrid(
            columnSizes: [1.fr, 1.fr],
            rowSizes: const [auto, auto],
            rowGap: 10,
            columnGap: 10,
            children: [
              for (int i = 0; i < 4; i++)
                Container(
                  height: 60,
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
            ],
          ),
          const Spacer(),
          BlackCustomButton(
            title: 'Submit',
            onPressed: () {},
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.15,
          ),
        ],
      ),
    );
  }
}
