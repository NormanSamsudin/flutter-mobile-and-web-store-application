import 'package:flutter/material.dart';
import 'package:mobile_application_store/views/screens/nav_screens/widgets/banner_widget.dart';
import 'package:mobile_application_store/views/screens/nav_screens/widgets/header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          HeaderWidget(),
          BannerWidget()
        ],
      )
    );
  }
}