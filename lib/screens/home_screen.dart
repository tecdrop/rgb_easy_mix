// Copyright (c) 2024 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file or at
// https://github.com/tecdrop/rgb_easy_mix/blob/main/LICENSE.

import 'package:flutter/material.dart';

import '../widgets/rgb_sliders_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color _color = Colors.white;

  final TextEditingController _redController = TextEditingController();
  final TextEditingController _greenController = TextEditingController();
  final TextEditingController _blueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('HomeScreen build');

    return Scaffold(
      backgroundColor: _color,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: RGBSliders(
          color: _color,
          redController: _redController,
          greenController: _greenController,
          blueController: _blueController,
          onColorChanged: (Color color) {
            _redController.text = color.red.toString();
            _greenController.text = color.green.toString();
            _blueController.text = color.blue.toString();
            setState(() {
              _color = color;
            });
          },
        ),
      ),
    );
  }
}
