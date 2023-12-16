import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:komodo_trivia/data/models/category_model.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget(
      {super.key,
      required this.image,
      required this.category,
      required this.heroTag});

  final int image;
  final QuizCategory category;
  final Object heroTag;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          'difficulty-page',
          extra: category,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        height: 100,
        width: 80,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Hero(
                tag: heroTag,
                child: Image.asset(
                  'assets/images/${image.toString()}.png',
                  height: 150,
                  width: 150,
                ),
              ),
            ),
            Text(
              category.name,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w500, height: 1),
            )
          ],
        ),
      ),
    );
  }
}
