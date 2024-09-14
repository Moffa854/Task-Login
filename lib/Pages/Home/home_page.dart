import 'package:flutter/material.dart';

import '../../Core/Constant/color_app.dart';

class HomePage extends StatelessWidget {
  final String emailTitle;
  const HomePage({super.key, required this.emailTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.whitePink,
        title: Text(
          emailTitle,
          style: const TextStyle(
            color: ColorApp.purple,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'Login Successful',
          style: TextStyle(
            color: ColorApp.purple,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
