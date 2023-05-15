import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context).colorScheme.primary;
    final titleThemeContext = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.movie_outlined,
                color: themeContext,
              ),
              const SizedBox(width: 5),
              Text('Cienemapedia', style: titleThemeContext),
              const Spacer(),
              IconButton(onPressed: (){}, icon: const Icon(Icons.search_rounded))
            ],
          ),
        ),
      ),
    );
  }
}
