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
