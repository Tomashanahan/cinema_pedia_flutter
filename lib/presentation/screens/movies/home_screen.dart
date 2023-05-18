import 'package:cinema_pedia_flutter/presentation/views/home_views/home_view.dart';
import 'package:cinema_pedia_flutter/presentation/widgets/shared/custom_bottom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'HomeScreen';
  final Widget childView;
  const HomeScreen({super.key, required this.childView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: childView,
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
