// Copyright (c) 2024 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file or at
// https://github.com/tecdrop/rgb_easy_mix/blob/main/LICENSE.

import 'package:flutter/material.dart';

/// Returns the black or white contrast color of a given color.
Color contrastOf(Color color) {
  return ThemeData.estimateBrightnessForColor(color) == Brightness.light
      ? Colors.black
      : Colors.white;
}
