import 'package:flutter/material.dart';

import '../widgets/rgb_sliders_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color _color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _color,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: RGBSliders(
          initialColor: Colors.white,
          onColorChanged: (Color color) {
            setState(() {
              _color = color;
            });
          },
        ),
      ),
    );
  }
}
