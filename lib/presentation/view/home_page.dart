import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komodo_trivia/logic/cubit/category_cubit/category_cubit.dart';
import 'package:komodo_trivia/presentation/widgets/common/black_custom_button.dart';
import 'package:komodo_trivia/presentation/widgets/common/error_widget.dart';
import 'package:komodo_trivia/presentation/widgets/home_page/category_widget.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            child: BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                if (state is CategorySuccessS) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hey There!',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'What subject you want to improve today?',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 14),
                      GridView.builder(
                          itemCount: state.categoryList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            final category = state.categoryList[index];
                            return CategoryWidget(
                              image: category.id,
                              category: category,
                              heroTag: UniqueKey(),
                            );
                          }),
                    ],
                  );
                }

                if (state is CategoryErrorS) {
                  if (state.errorString == '1') {
                    return const CustomErrorWidget(
                      assetName: 'no_data_found.json',
                      errorString:
                          "Oops! It seems there aren't enough questions. Please consider adjusting the number, difficulty level, or question type and try again",
                    );
                  }
                  if (state.errorString == '3' ||
                      state.errorString == '4' ||
                      state.errorString == '5') {
                    return const CustomErrorWidget(
                      assetName: 'server-error.json',
                      errorString:
                          "Oops! Too many requests at once. Please wait for 5 seconds!",
                    );
                  }
                  if (state.errorString == 'socketerror') {
                    return Column(
                      children: [
                        const CustomErrorWidget(
                            assetName: 'server-error.json',
                            errorString:
                                "Oops! We're having trouble connecting to the server. Please ensure your internet connection is stable and try again."),
                        BlackCustomButton(
                            title: 'Try again',
                            onPressed: () {
                              context.read<CategoryCubit>().getCategories();
                            })
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        const CustomErrorWidget(
                            assetName: 'server-error.json',
                            errorString:
                                'Please wait for 5 seconds before making another request.'),
                        BlackCustomButton(
                            title: 'Try again',
                            onPressed: () {
                              context.read<CategoryCubit>().getCategories();
                            })
                      ],
                    );
                  }
                }

                return Shimmer.fromColors(
                  baseColor: const Color(0xffF1F1F1),
                  highlightColor: Colors.grey.shade50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        width: 100,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 20,
                        width: 300,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 14),
                      GridView.builder(
                          itemCount: 12,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                                baseColor: const Color(0xffF1F1F1),
                                highlightColor: Colors.grey.shade50,
                                child: Container(
                                  height: 100,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                ));
                          }),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
